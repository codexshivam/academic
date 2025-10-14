# 🎵 AuraTune Analysis Function

## Overview

This Python serverless function analyzes user Spotify data to generate personalized musical aura profiles. It processes audio features, determines personality types, and manages user profiles with intelligent first-time vs returning user handling.

## 🚀 Features

### ✅ **Enhanced Error Handling**
- Specific Spotify API error handling
- Database operation error management
- Graceful fallbacks for missing data
- Detailed error codes and messages

### ✅ **Smart User Management**
- Automatic first-time vs returning user detection
- Profile creation for new users
- Profile updates for existing users
- Analysis count tracking

### ✅ **Advanced Data Processing**
- Rolling average for aura vectors (70% new, 30% historical)
- UTC timestamp handling
- Data validation and cleanup
- Neutral value fallbacks

### ✅ **Comprehensive Logging**
- Detailed execution logging
- Performance metrics
- Error tracking
- User activity monitoring

## 📊 Input Payload

```json
{
  "accessToken": "spotify_oauth_token",
  "spotifyId": "user_spotify_id",
  "displayName": "user_display_name",
  "email": "user_email@example.com",
  "profileImageUrl": "https://profile_image_url",
  "isFirstTime": false,
  "updateExisting": false
}
```

### Required Fields
- `accessToken`: Spotify OAuth token
- `spotifyId`: Unique Spotify user ID
- `displayName`: User's display name

### Optional Fields
- `email`: User's email address
- `profileImageUrl`: Profile image URL
- `isFirstTime`: Boolean flag for new users
- `updateExisting`: Boolean flag for updates

## 🎯 Output Response

### Success Response
```json
{
  "success": true,
  "data": {
    "spotifyId": "user_spotify_id",
    "displayName": "User Name",
    "auraVector": [0.7, 0.8, 0.6, 0.3, 0.2],
    "auraPersonality": "High-Energy Dynamo",
    "lastUpdated": "2025-01-01T12:00:00.000Z",
    "isFirstTime": false,
    "analysisCount": 3,
    "email": "user@example.com",
    "profileImageUrl": "https://image_url"
  },
  "metadata": {
    "tracksAnalyzed": 50,
    "validFeatures": 48,
    "analysisCount": 3,
    "isFirstTime": false,
    "timestamp": "2025-01-01T12:00:00.000Z"
  }
}
```

### Error Response
```json
{
  "error": "Error description",
  "code": "ERROR_CODE",
  "timestamp": "2025-01-01T12:00:00.000Z"
}
```

## 🧠 Personality Classification

| Personality Type | Conditions | Description |
|------------------|------------|-------------|
| **High-Energy Dynamo** | Energy > 0.7 & Danceability > 0.6 | Energetic, upbeat music lover |
| **Introspective Thinker** | Valence < 0.3 & Acousticness > 0.5 | Contemplative, emotional listener |
| **Acoustic Soul** | Acousticness > 0.7 | Organic, authentic sound lover |
| **Dance Enthusiast** | Danceability > 0.7 | Rhythm-focused music lover |
| **Balanced Listener** | Default | Versatile, well-rounded taste |

## 🔧 Error Codes

| Code | Description | HTTP Status |
|------|-------------|-------------|
| `MISSING_DATA` | Required payload fields missing | 400 |
| `SPOTIFY_AUTH_ERROR` | Invalid or expired Spotify token | 401 |
| `NO_TRACK_DATA` | No track data found | 404 |
| `NO_AUDIO_FEATURES` | Unable to fetch audio features | 500 |
| `NO_VALID_FEATURES` | No valid audio features found | 500 |
| `PROCESSING_ERROR` | Error processing audio features | 500 |
| `DATABASE_ERROR` | Database operation failed | 500 |
| `SPOTIFY_FETCH_ERROR` | Spotify API fetch error | 500 |

## 🎵 Audio Features Analyzed

| Feature | Range | Description |
|---------|-------|-------------|
| **Danceability** | 0.0 - 1.0 | How suitable for dancing |
| **Energy** | 0.0 - 1.0 | Perceptual intensity and power |
| **Valence** | 0.0 - 1.0 | Musical positivity/happiness |
| **Acousticness** | 0.0 - 1.0 | Confidence of acoustic sound |
| **Instrumentalness** | 0.0 - 1.0 | Predicts vocal vs instrumental |

## 🔄 User Flow Logic

### First-Time Users
1. Check if profile exists → No
2. Create new profile with `isFirstTime: true`
3. Set `analysisCount: 1`
4. Store complete user data

### Returning Users
1. Check if profile exists → Yes
2. Retrieve existing data
3. Apply rolling average (70% new, 30% historical)
4. Increment `analysisCount`
5. Update profile with `isFirstTime: false`

## 📈 Rolling Average Algorithm

For returning users with multiple analyses:

```python
# Weighted average calculation
old_vec = np.array(existing_data.get("auraVector", [0.5]*5))
new_vec = np.array(aura_data['auraVector'])
weighted_vec = (new_vec * 0.7) + (old_vec * 0.3)
```

This ensures:
- Recent listening habits have more influence (70%)
- Historical patterns are preserved (30%)
- Smooth transitions between analyses

## 🛡️ Security & Validation

### Data Validation
- Required field validation
- Spotify token validation
- Audio feature validation
- Database operation validation

### Error Handling
- Graceful degradation
- Fallback values
- Detailed error logging
- User-friendly error messages

### Data Cleanup
- Remove None values
- Validate numeric ranges
- Sanitize string inputs
- UTC timestamp normalization

## 📊 Performance Optimizations

### Efficient Processing
- Filter None values before DataFrame creation
- Use vectorized NumPy operations
- Minimal database queries
- Optimized data structures

### Memory Management
- Clean up temporary variables
- Efficient DataFrame operations
- Minimal data copying
- Garbage collection friendly

## 🔍 Monitoring & Logging

### Execution Logging
```
🎵 Analyzing music for user: John Doe
📊 Found 50 tracks to analyze
🎯 Computed aura vector: [0.7 0.8 0.6 0.3 0.2]
🧠 Determined personality: High-Energy Dynamo
💾 Prepared aura data for storage: ['spotifyId', 'displayName', ...]
🔄 Applied rolling average (count: 3)
✅ Updated profile for returning user: spotify_123 (analysis #4)
🎵 Analysis complete for John Doe
```

### Error Logging
```
❌ Spotify API error: Invalid access token
❌ Database error: Connection timeout
⚠️ Rolling average failed, using new data: Division by zero
```

## 🚀 Deployment

### Environment Variables
```bash
APPWRITE_ENDPOINT=https://cloud.appwrite.io/v1
APPWRITE_PROJECT_ID=your_project_id
APPWRITE_API_KEY=your_api_key
APPWRITE_DATABASE_ID=your_database_id
APPWRITE_COLLECTION_ID=your_collection_id
```

### Dependencies
```txt
pandas
numpy
spotipy
appwrite-sdk
```

### Deployment Command
```bash
appwrite deploy function --functionId analyze-aura
```

## 🧪 Testing

### Test Cases
1. **First-time user analysis**
2. **Returning user update**
3. **Spotify API errors**
4. **Database connection issues**
5. **Invalid audio features**
6. **Missing required fields**

### Test Payloads
```json
// First-time user
{
  "accessToken": "valid_token",
  "spotifyId": "new_user_123",
  "displayName": "New User",
  "isFirstTime": true
}

// Returning user
{
  "accessToken": "valid_token",
  "spotifyId": "existing_user_456",
  "displayName": "Existing User",
  "isFirstTime": false,
  "updateExisting": true
}
```

## 📚 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `pandas` | Latest | Data manipulation and analysis |
| `numpy` | Latest | Numerical computations |
| `spotipy` | Latest | Spotify Web API client |
| `appwrite-sdk` | Latest | Appwrite database operations |

## 🔧 Configuration

### Function Settings
- **Runtime**: Python 3.10
- **Memory**: 512MB
- **Timeout**: 60 seconds
- **Execute Access**: Users role

### Database Schema
```sql
Collection: profiles
Attributes:
  - spotifyId (String, required)
  - displayName (String, required)
  - auraVector (Float array, required)
  - auraPersonality (String, optional)
  - lastUpdated (String, optional)
  - isFirstTime (Boolean, optional)
  - email (String, optional)
  - profileImageUrl (String, optional)
  - analysisCount (Integer, optional)
```

## 🎯 Best Practices

### Code Quality
- Comprehensive error handling
- Detailed logging
- Input validation
- Output standardization

### Performance
- Efficient data processing
- Minimal API calls
- Optimized database operations
- Memory-conscious operations

### Security
- Input sanitization
- Error message sanitization
- Secure token handling
- Database query validation

---

**🎵 Made with ❤️ for AuraTune - Discover Your Musical DNA**
