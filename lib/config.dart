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
  static const String successUrl = 'https://fra.cloud.appwrite.io/v1/account/sessions/oauth2/callback/spotify/projects-from-shivam';
  static const String failureUrl = 'https://fra.cloud.appwrite.io/v1/account/sessions/oauth2/callback/spotify/projects-from-shivam';

  // Convenience getter: the exact Appwrite OAuth callback URL Spotify will be
  // redirected to. This includes the project id and must be registered in
  // your Spotify app's Redirect URIs list (exact match required).
  // Example value produced by this getter:
  // https://fra.cloud.appwrite.io/v1/account/sessions/oauth2/callback/spotify/projects-from-shivam
  static String get appwriteOAuthCallback =>
      '$endpoint/account/sessions/oauth2/callback/spotify/$projectId';

  // Suggested Spotify redirect URIs to register (copies the computed
  // Appwrite callback and a common cloud.appwrite.io variant). Add these
  // exact strings to the Spotify Developer Dashboard → Your App → Edit
  // Settings → Redirect URIs.
  static List<String> get suggestedSpotifyRedirectUris => [
  appwriteOAuthCallback, 
        // alternate Appwrite host used in some regions
        endpoint.replaceAll('fra.', 'cloud.').replaceAll('/v1', '') +
            '/v1/account/sessions/oauth2/callback/spotify/$projectId',
      ];

  // Suggested web origins to add in Appwrite project settings (Platforms / Web)
  static List<String> get suggestedWebOrigins => [
        successUrl,
        'http://localhost:3000',
      ];
}

// Instructions:
// 1. Copy this file to config.dart: cp lib/config.dart.template lib/config.dart
// 2. Copy your Project ID from Appwrite Console -> Project Settings
// 3. Copy your Database ID from Appwrite Console -> Database -> Your Database
// 4. Copy your Collection ID from Appwrite Console -> Database -> Your Database -> Your Collection
// 5. Update the redirect URLs when deploying to production
