// AuraTune Configuration Template
// Copy this file to config.dart and replace the placeholder values

class AppwriteConfig {
  // Appwrite Cloud endpoint (usually doesn't change)
  static const String endpoint = 'https://fra.cloud.appwrite.io/v1';
  
  // Your Appwrite Project ID (found in your project settings)
  static const String projectId = 'projects-from-shivam';
  
  // Your Appwrite Function ID for the analyze-aura function
  static const String analyzeFunctionId = 'analyze_aura_auratune';
  
  // Your Appwrite Database ID (found in your database settings)
  static const String databaseId = 'auratune_database';
  
  // Your Appwrite Collection ID (found in your collection settings)
  static const String collectionId = 'profiles';
  
  // Redirect URLs for OAuth (update these for production)
  static const String successUrl = 'https://auratune.shivamyadav.com.np';
  static const String failureUrl = 'https://auratune.shivamyadav.com.np';

  // Spotify OAuth scopes required by the analyze-aura function. These
  // should also be added to the Spotify app settings and configured in
  // Appwrite's Spotify provider. When logging in, Appwrite will request
  // these scopes so the access token has permission to read user data.
  static const List<String> spotifyScopes = [
    'user-top-read',
    'user-read-email',
    'user-read-private',
  ];
}

// Instructions:
// 1. Copy this file to config.dart: cp lib/config.dart.template lib/config.dart
// 2. Copy your Project ID from Appwrite Console -> Project Settings
// 3. Copy your Database ID from Appwrite Console -> Database -> Your Database
// 4. Copy your Collection ID from Appwrite Console -> Database -> Your Database -> Your Collection
// 5. Update the redirect URLs when deploying to production
