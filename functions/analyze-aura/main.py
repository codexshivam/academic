import os
import json
import numpy as np
import pandas as pd
import spotipy
from datetime import datetime, timezone
from appwrite.client import Client
from appwrite.services.databases import Databases
from appwrite.id import ID
from appwrite.query import Query
from spotipy.exceptions import SpotifyException

def main(context):
    # Initialize Appwrite client from environment variables
    client = Client()
    client.set_endpoint(os.environ["APPWRITE_ENDPOINT"])
    client.set_project(os.environ["APPWRITE_PROJECT_ID"])
    client.set_key(os.environ["APPWRITE_API_KEY"])

    # Decode the request payload
    payload = json.loads(context.req.body)
    access_token = payload.get("accessToken")
    spotify_id = payload.get("spotifyId")
    display_name = payload.get("displayName")
    client_aura_vector = payload.get("auraVector")  # Optional: provided by client
    is_first_time = payload.get("isFirstTime", False)
    update_existing = payload.get("updateExisting", False)
    email = payload.get("email")
    profile_image_url = payload.get("profileImageUrl")

    # Validate minimal payload
    if client_aura_vector is None and access_token is None:
        return context.res.json({
            "error": "Missing payload: provide either 'auraVector' or a valid Spotify 'accessToken'",
            "code": "MISSING_INPUT"
        }, 400)

    if not display_name:
        display_name = None  # Will attempt to derive below if possible

    # 0. Resolve Spotify user identity from token if needed
    # If we have an access token, resolve Spotify identity for canonical keying
    sp = None
    if access_token:
        try:
            sp = spotipy.Spotify(auth=access_token)
            me = sp.current_user()
            resolved_spotify_id = me.get("id") if me else None
            resolved_display_name = me.get("display_name") if me else None
            if resolved_spotify_id:
                spotify_id = resolved_spotify_id
            if resolved_display_name and not display_name:
                display_name = resolved_display_name
        except SpotifyException as e:
            print(f"❌ Spotify profile fetch error: {str(e)}")
            # If client provided auraVector, we can still proceed without Spotify profile
            if client_aura_vector is None:
                return context.res.json({
                    "error": "Invalid or missing Spotify scopes/token. Ensure user-top-read and user-read-private are granted.",
                    "code": "SPOTIFY_AUTH_ERROR"
                }, 401)
        except Exception as e:
            print(f"❌ Unexpected error fetching Spotify profile: {str(e)}")
            if client_aura_vector is None:
                return context.res.json({
                    "error": f"Failed to fetch Spotify profile: {str(e)}",
                    "code": "SPOTIFY_PROFILE_ERROR"
                }, 500)

    # 1. Build aura vector from either client input or Spotify data
    if client_aura_vector is not None:
        # Client provided the precomputed aura vector; validate and use directly
        try:
            if not isinstance(client_aura_vector, (list, tuple)):
                raise ValueError("auraVector must be a list of numbers")
            aura_vector = np.array([float(x) for x in client_aura_vector], dtype=float)
            if aura_vector.size not in (5,):
                # Expected vector length 5 as per UI features
                print(f"⚠️ Unexpected auraVector length: {aura_vector.size}")
            print(f"🎯 Using client-provided aura vector: {aura_vector}")
        except Exception as e:
            return context.res.json({
                "error": f"Invalid auraVector payload: {str(e)}",
                "code": "INVALID_AURA_VECTOR"
            }, 400)
    else:
        # Compute aura vector from Spotify top tracks (server-side path)
        try:
            if sp is None:
                sp = spotipy.Spotify(auth=access_token)
            print(f"🎵 Analyzing music for user: {display_name}")
            # Fetch top tracks with better error handling
            top_tracks = sp.current_user_top_tracks(limit=50, time_range="medium_term")
            if not top_tracks['items']:
                return context.res.json({
                    "error": "No track data found. Please listen to more music on Spotify.",
                    "code": "NO_TRACK_DATA"
                }, 404)
            
            track_ids = [item['id'] for item in top_tracks['items']]
            print(f"📊 Found {len(track_ids)} tracks to analyze")
            
            # Fetch audio features with error handling
            audio_features = sp.audio_features(tracks=track_ids)
            if not audio_features or all(feature is None for feature in audio_features):
                return context.res.json({
                    "error": "Unable to fetch audio features for tracks.",
                    "code": "NO_AUDIO_FEATURES"
                }, 500)

            # Filter out None values and create DataFrame
            valid_features = [f for f in audio_features if f is not None]
            if not valid_features:
                return context.res.json({
                    "error": "No valid audio features found.",
                    "code": "NO_VALID_FEATURES"
                }, 500)
            
            df = pd.DataFrame(valid_features)
            feature_cols = ['danceability', 'energy', 'valence', 'acousticness', 'instrumentalness']
            
            # Ensure all columns exist, fill with neutral values if not
            for col in feature_cols:
                if col not in df.columns:
                    df[col] = 0.5  # Neutral value instead of 0
            
            # Compute aura vector with error handling
            aura_vector = df[feature_cols].mean().to_numpy()
            print(f"🎯 Computed aura vector: {aura_vector}")
            
        except SpotifyException as e:
            print(f"❌ Spotify API error: {str(e)}")
            return context.res.json({
                "error": "Invalid or expired Spotify token. Please log in again.",
                "code": "SPOTIFY_AUTH_ERROR"
            }, 401)
        except Exception as e:
            print(f"❌ Error processing audio features: {str(e)}")
            return context.res.json({
                "error": f"Failed to process audio features: {str(e)}",
                "code": "PROCESSING_ERROR"
            }, 500)

    # 2. Determine Personality with more sophisticated logic
    try:
        danceability, energy, valence, acousticness, instrumentalness = aura_vector
        
        personality = "Balanced Listener"  # Default
        
        if energy > 0.7 and danceability > 0.6:
            personality = "High-Energy Dynamo"
        elif valence < 0.3 and acousticness > 0.5:
            personality = "Introspective Thinker"
        elif acousticness > 0.7:
            personality = "Acoustic Soul"
        elif danceability > 0.7:
            personality = "Dance Enthusiast"
        elif energy > 0.6 and valence > 0.6:
            personality = "High-Energy Dynamo"
        elif valence < 0.4 and energy < 0.4:
            personality = "Introspective Thinker"
        
        print(f"🧠 Determined personality: {personality}")
        
    except Exception as e:
        print(f"❌ Error determining personality: {str(e)}")
        personality = "Balanced Listener"  # Fallback

    # 3. Store results in Appwrite Database
    databases = Databases(client)
    db_id = os.environ["APPWRITE_DATABASE_ID"]
    collection_id = os.environ["APPWRITE_COLLECTION_ID"]

    # Prepare aura data with user tracking and clean up None values
    if not spotify_id:
        return context.res.json({
            "error": "Unable to determine Spotify user id. Provide accessToken or spotifyId.",
            "code": "MISSING_SPOTIFY_ID"
        }, 400)

    aura_data = {
        "spotifyId": spotify_id,
        "displayName": display_name or "User",
        "auraVector": [float(x) for x in aura_vector],
        "auraPersonality": personality,
        "lastUpdated": datetime.now(timezone.utc).isoformat() + "Z",  # UTC timestamp
        "isFirstTime": is_first_time,
        "analysisCount": 1
    }
    
    # Add optional fields only if they exist
    if email is not None:
        aura_data["email"] = email
    if profile_image_url is not None:
        aura_data["profileImageUrl"] = profile_image_url
    
    # Clean up None values
    aura_data = {k: v for k, v in aura_data.items() if v is not None}
    
    print(f"💾 Prepared aura data for storage: {list(aura_data.keys())}")

    # Handle user profile creation/update based on user type
    try:
        docs = databases.list_documents(db_id, collection_id, [Query.equal("spotifyId", spotify_id)])
        
        if docs['total'] > 0:
            # Existing user - update profile and increment analysis count
            doc_id = docs['documents'][0]['$id']
            existing_data = docs['documents'][0]
            
            # Get current analysis count
            current_count = existing_data.get('analysisCount', 1)
            
            # Optional: Implement rolling average for aura vector
            if current_count > 1 and existing_data.get('auraVector'):
                try:
                    old_vec = np.array(existing_data.get("auraVector", [0.5]*5))
                    new_vec = np.array(aura_data['auraVector'])
                    # Weighted average: 70% new data, 30% historical
                    weighted_vec = (new_vec * 0.7) + (old_vec * 0.3)
                    aura_data['auraVector'] = [float(x) for x in weighted_vec]
                    print(f"🔄 Applied rolling average (count: {current_count})")
                except Exception as e:
                    print(f"⚠️ Rolling average failed, using new data: {str(e)}")
            
            # Update analysis count and ensure isFirstTime is false
            aura_data['analysisCount'] = current_count + 1
            aura_data['isFirstTime'] = False
            
            # Update existing document using patch update
            databases.update_document(db_id, collection_id, doc_id, aura_data)
            print(f"✅ Updated profile for returning user: {spotify_id} (analysis #{current_count + 1})")
            
        else:
            # New user - create profile
            aura_data['isFirstTime'] = True
            aura_data['analysisCount'] = 1
            
            # Create new document
            databases.create_document(db_id, collection_id, ID.unique(), aura_data)
            print(f"🎉 Created new profile for first-time user: {spotify_id}")
            
    except Exception as e:
        print(f"❌ Database error: {str(e)}")
        return context.res.json({
            "error": f"Database operation failed: {str(e)}",
            "code": "DATABASE_ERROR"
        }, 500)

    # Final logging and response
    print(f"🎵 Analysis complete for {display_name}")
    print(f"📊 Personality: {personality}")
    print(f"🔢 Analysis count: {aura_data.get('analysisCount', 1)}")
    print(f"⏰ Timestamp: {aura_data.get('lastUpdated', 'N/A')}")
    
    return context.res.json({
        "success": True,
        "data": aura_data,
        "metadata": {
            "tracksAnalyzed": len(track_ids) if 'track_ids' in locals() else 0,
            "validFeatures": len(valid_features) if 'valid_features' in locals() else 0,
            "analysisCount": aura_data.get('analysisCount', 1),
            "isFirstTime": aura_data.get('isFirstTime', False),
            "timestamp": aura_data.get('lastUpdated')
        }
    })
