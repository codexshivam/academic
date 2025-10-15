# 🎵 AuraTune Analysis Function

## Overview

Analyzes user Spotify data to generate personalized musical aura profiles. Processes audio features, determines personality types, and manages user profiles.

## Features

- **Smart User Management**: Automatic detection of first-time vs returning users
- **Data Processing**: Rolling average algorithm (70% new, 30% historical data)
- **Error Handling**: Comprehensive error management with fallbacks
- **Logging**: Detailed execution and error tracking

## Input

**Required:**
- `accessToken`: Spotify OAuth token
- `spotifyId`: Unique Spotify user ID
- `displayName`: User's display name

**Optional:**
- `email`, `profileImageUrl`, `isFirstTime`, `updateExisting`

## Output

**Success:** Returns user profile with aura vector, personality type, and metadata

**Error:** Returns error message with code and timestamp

## Personality Types

- **High-Energy Dynamo**: Energy > 0.7 & Danceability > 0.6
- **Introspective Thinker**: Valence < 0.3 & Acousticness > 0.5  
- **Acoustic Soul**: Acousticness > 0.7
- **Dance Enthusiast**: Danceability > 0.7
- **Balanced Listener**: Default fallback

## Audio Features

Analyzes 5 key features (0.0-1.0 range): Danceability, Energy, Valence, Acousticness, Instrumentalness

## How It Works

**First-time users**: Creates new profile with analysis count 1

**Returning users**: Applies rolling average (70% new data, 30% historical) and increments analysis count

## Deployment

**Environment Variables:**
- `APPWRITE_ENDPOINT`, `APPWRITE_PROJECT_ID`, `APPWRITE_API_KEY`
- `APPWRITE_DATABASE_ID`, `APPWRITE_COLLECTION_ID`

**Dependencies:** pandas, numpy, spotipy, appwrite-sdk

**Deploy:** `appwrite deploy function --functionId analyze-aura`
