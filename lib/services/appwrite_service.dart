import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import '../config.dart';
import '../models/aura_data.dart';

class AppwriteService {
  static final AppwriteService _instance = AppwriteService._internal();
  factory AppwriteService() => _instance;
  AppwriteService._internal();

  late Client _client;
  late Account _account;
  late Functions _functions;
  late Databases _databases;

  void initialize() {
    _client = Client()
        .setEndpoint(AppwriteConfig.endpoint)
        .setProject(AppwriteConfig.projectId)
        .setSelfSigned(status: true);

    _account = Account(_client);
    _functions = Functions(_client);
    _databases = Databases(_client);
  }

  /// Debug helper: prints the current Appwrite session details to console.
  /// Useful to verify whether the session/cookie is present and contains
  /// a provider access token after OAuth redirects.
  Future<void> debugPrintSession() async {
    try {
      final session = await _account.getSession(sessionId: 'current');
      // Print a couple of non-sensitive details to help debugging.
      // Avoid printing full tokens in production logs.
      // ignore: avoid_print
      debugPrint('Appwrite session id: ${session.$id}');
      // Print token length instead of token itself to reduce risk
      // ignore: avoid_print
      debugPrint('providerAccessToken length: ${session.providerAccessToken.length}');
    } catch (e) {
      try {
        // ignore: avoid_print
        debugPrint('debugPrintSession error: $e');
      } catch (_) {}
    }
  }

  // Authentication methods
  Future<User?> getCurrentUser() async {
    try {
      return await _account.get();
    } catch (e) {
      // Log the error to help debugging when the client cannot fetch the
      // current user (commonly due to missing/blocked session cookie).
      // Returning null preserves existing behavior but with better visibility.
      // Use debugPrint to avoid bringing in a logging package.
      // Re-throwing here would change runtime behavior; keep returning null
      // so callers can handle unauthenticated state.
      // Example: see DevTools Network -> check /v1/account request/response.
      // Print the error and stacktrace if available.
      try {
        // ignore: avoid_print
        debugPrint('getCurrentUser error: $e');
      } catch (_) {}
      return null;
    }
  }

  Future<void> loginWithSpotify() async {
    try {
      await _account.createOAuth2Session(
        provider: 'spotify',
        success: AppwriteConfig.successUrl,
        failure: AppwriteConfig.failureUrl,
        scopes: AppwriteConfig.spotifyScopes,
      );
    } catch (e) {
      throw AppwriteException('Failed to login with Spotify: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } catch (e) {
      throw AppwriteException('Failed to logout: $e');
    }
  }

  // Check if user profile exists
  Future<bool> userProfileExists(String spotifyId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.collectionId,
        queries: [Query.equal('spotifyId', spotifyId)],
      );
      return response.documents.isNotEmpty;
    } catch (e) {
      // Log database lookup errors to help diagnose why profile checks fail.
      try {
        // ignore: avoid_print
        debugPrint('userProfileExists error: $e');
      } catch (_) {}
      return false;
    }
  }

  // Create user profile for first-time users
  Future<AuraData> createUserProfile(String userId, String displayName, String? email, String? profileImageUrl) async {
    try {
      final session = await _account.getSession(sessionId: 'current');
      final accessToken = session.providerAccessToken;

      if (accessToken.isEmpty) {
        throw AppwriteException('No access token available (session missing or provider token empty)');
      }

      final payload = json.encode({
        'accessToken': accessToken,
        'spotifyId': userId,
        'displayName': displayName,
        'isFirstTime': true,
        'email': email,
        'profileImageUrl': profileImageUrl,
      });

        final result = await _functions.createExecution(
          functionId: AppwriteConfig.analyzeFunctionId,
          body: payload,
        );

        if (result.status == 'completed') {
          final responseData = json.decode(result.responseBody);
          
          // Handle new response format with success flag
          if (responseData['success'] == true && responseData['data'] != null) {
            return AuraData.fromJson(responseData['data']);
          } else if (responseData['spotifyId'] != null) {
            // Handle legacy response format
            return AuraData.fromJson(responseData);
          } else {
            throw AppwriteException('Invalid response format from function');
          }
        } else {
          throw AppwriteException('Function execution failed: ${result.responseBody}');
        }
    } catch (e) {
      throw AppwriteException('Failed to create user profile: $e');
    }
  }

  // Update existing user profile and refresh aura data
  Future<AuraData> updateUserProfile(String userId, String displayName) async {
    try {
      final session = await _account.getSession(sessionId: 'current');
      final accessToken = session.providerAccessToken;

      if (accessToken.isEmpty) {
        throw AppwriteException('No access token available (session missing or provider token empty)');
      }

      final payload = json.encode({
        'accessToken': accessToken,
        'spotifyId': userId,
        'displayName': displayName,
        'isFirstTime': false,
        'updateExisting': true,
      });

        final result = await _functions.createExecution(
          functionId: AppwriteConfig.analyzeFunctionId,
          body: payload,
        );

        if (result.status == 'completed') {
          final responseData = json.decode(result.responseBody);
          
          // Handle new response format with success flag
          if (responseData['success'] == true && responseData['data'] != null) {
            return AuraData.fromJson(responseData['data']);
          } else if (responseData['spotifyId'] != null) {
            // Handle legacy response format
            return AuraData.fromJson(responseData);
          } else {
            throw AppwriteException('Invalid response format from function');
          }
        } else {
          throw AppwriteException('Function execution failed: ${result.responseBody}');
        }
    } catch (e) {
      throw AppwriteException('Failed to update user profile: $e');
    }
  }

  // Aura analysis methods (backward compatibility)
  Future<AuraData> analyzeUserAura(String userId, String displayName) async {
    try {
      final session = await _account.getSession(sessionId: 'current');
      final accessToken = session.providerAccessToken;

      if (accessToken.isEmpty) {
        throw AppwriteException('No access token available (session missing or provider token empty)');
      }

      final payload = json.encode({
        'accessToken': accessToken,
        'spotifyId': userId,
        'displayName': displayName,
      });

        final result = await _functions.createExecution(
          functionId: AppwriteConfig.analyzeFunctionId,
          body: payload,
        );

        if (result.status == 'completed') {
          final responseData = json.decode(result.responseBody);
          
          // Handle new response format with success flag
          if (responseData['success'] == true && responseData['data'] != null) {
            return AuraData.fromJson(responseData['data']);
          } else if (responseData['spotifyId'] != null) {
            // Handle legacy response format
            return AuraData.fromJson(responseData);
          } else {
            throw AppwriteException('Invalid response format from function');
          }
        } else {
          throw AppwriteException('Function execution failed: ${result.responseBody}');
        }
    } catch (e) {
      throw AppwriteException('Failed to analyze aura: $e');
    }
  }

  // New flow: client computes aura vector and sends it to the function.
  // The function will derive the Spotify user id from the access token if
  // possible, otherwise it will use the provided spotifyId field.
  Future<AuraData> submitAuraVector({
    required String userId,
    required String displayName,
    required List<double> auraVector,
    String? email,
    String? profileImageUrl,
  }) async {
    try {
      final session = await _account.getSession(sessionId: 'current');
      final accessToken = session.providerAccessToken; // may be needed to derive Spotify id

      final payload = json.encode({
        'accessToken': accessToken, // optional but recommended for deriving spotifyId
        'spotifyId': userId, // fallback; function prefers token-derived id
        'displayName': displayName,
        'auraVector': auraVector,
        'email': email,
        'profileImageUrl': profileImageUrl,
      });

      final result = await _functions.createExecution(
        functionId: AppwriteConfig.analyzeFunctionId,
        body: payload,
      );

      if (result.status == 'completed') {
        final responseData = json.decode(result.responseBody);
        if (responseData['success'] == true && responseData['data'] != null) {
          return AuraData.fromJson(responseData['data']);
        } else if (responseData['spotifyId'] != null) {
          return AuraData.fromJson(responseData);
        } else {
          throw AppwriteException('Invalid response format from function');
        }
      } else {
        throw AppwriteException('Function execution failed: ${result.responseBody}');
      }
    } catch (e) {
      throw AppwriteException('Failed to submit aura vector: $e');
    }
  }

  // Database methods
  Future<AuraData?> getUserAuraData(String userId) async {
    try {
      final docs = await _databases.listDocuments(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.collectionId,
        queries: [Query.equal('spotifyId', userId)],
      );

      if (docs.total > 0) {
        final doc = docs.documents.first;
        return AuraData.fromJson(doc.data);
      }
      return null;
    } catch (e) {
      throw AppwriteException('Failed to fetch user aura data: $e');
    }
  }

  Future<void> saveUserAuraData(AuraData auraData) async {
    try {
      final docs = await _databases.listDocuments(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.collectionId,
        queries: [Query.equal('spotifyId', auraData.spotifyId)],
      );

      final data = auraData.toJson();
      data['lastUpdated'] = DateTime.now().toIso8601String();

      if (docs.total > 0) {
        // Update existing document
        await _databases.updateDocument(
          databaseId: AppwriteConfig.databaseId,
          collectionId: AppwriteConfig.collectionId,
          documentId: docs.documents.first.$id,
          data: data,
        );
      } else {
        // Create new document
        await _databases.createDocument(
          databaseId: AppwriteConfig.databaseId,
          collectionId: AppwriteConfig.collectionId,
          documentId: ID.unique(),
          data: data,
        );
      }
    } catch (e) {
      throw AppwriteException('Failed to save user aura data: $e');
    }
  }
}

class AppwriteException implements Exception {
  final String message;
  const AppwriteException(this.message);

  @override
  String toString() => 'AppwriteException: $message';
}
