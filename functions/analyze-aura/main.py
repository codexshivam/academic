import os
import json
import numpy as np
import pandas as pd
import spotipy
from datetime import datetime
from appwrite.client import Client
from appwrite.services.databases import Databases
from appwrite.id import ID
from appwrite.query import Query

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
    is_first_time = payload.get("isFirstTime", False)
    update_existing = payload.get("updateExisting", False)
    email = payload.get("email")
    profile_image_url = payload.get("profileImageUrl")

    if not all([access_token, spotify_id, display_name]):
        return context.res.json({"error": "Missing required payload data."}, 400)

    # 1. Analyze Music with Spotipy, NumPy, Pandas
    sp = spotipy.Spotify(auth=access_token)
    try:
        top_tracks = sp.current_user_top_tracks(limit=50, time_range="medium_term")
        if not top_tracks['items']:
             return context.res.json({"error": "No track data found."}, 404)
        track_ids = [item['id'] for item in top_tracks['items']]
        audio_features = sp.audio_features(tracks=track_ids)
    except Exception as e:
        return context.res.json({"error": f"Spotify API error: {str(e)}"}, 500)

    df = pd.DataFrame(audio_features)
    feature_cols = ['danceability', 'energy', 'valence', 'acousticness', 'instrumentalness']
    # Ensure all columns exist, fill with 0 if not
    for col in feature_cols:
        if col not in df.columns:
            df[col] = 0

    aura_vector = df[feature_cols].mean().to_numpy()

    # 2. Determine Personality with more sophisticated logic
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

    # 3. Store results in Appwrite Database
    databases = Databases(client)
    db_id = os.environ["APPWRITE_DATABASE_ID"]
    collection_id = os.environ["APPWRITE_COLLECTION_ID"]

    # Prepare aura data with user tracking
    aura_data = {
        "spotifyId": spotify_id,
        "displayName": display_name,
        "auraVector": [float(x) for x in aura_vector],
        "auraPersonality": personality,
        "lastUpdated": datetime.now().isoformat(),
        "isFirstTime": is_first_time,
        "email": email,
        "profileImageUrl": profile_image_url,
        "analysisCount": 1
    }

    # Handle user profile creation/update based on user type
    try:
        docs = databases.list_documents(db_id, collection_id, [Query.equal("spotifyId", spotify_id)])
        
        if docs['total'] > 0:
            # Existing user - update profile and increment analysis count
            doc_id = docs['documents'][0]['$id']
            existing_data = docs['documents'][0]
            
            # Increment analysis count
            current_count = existing_data.get('analysisCount', 1)
            aura_data['analysisCount'] = current_count + 1
            aura_data['isFirstTime'] = False  # Ensure this is false for returning users
            
            # Update existing document
            databases.update_document(db_id, collection_id, doc_id, aura_data)
            print(f"Updated profile for returning user: {spotify_id}")
        else:
            # New user - create profile
            aura_data['isFirstTime'] = True
            aura_data['analysisCount'] = 1
            
            # Create new document
            databases.create_document(db_id, collection_id, ID.unique(), aura_data)
            print(f"Created new profile for first-time user: {spotify_id}")
            
    except Exception as e:
        return context.res.json({"error": f"Database error: {str(e)}"}, 500)

    return context.res.json(aura_data)
