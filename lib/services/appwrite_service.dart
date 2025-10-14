import 'dart:convert';
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

  // Authentication methods
  Future<User?> getCurrentUser() async {
    try {
      return await _account.get();
    } catch (e) {
      return null;
    }
  }

  Future<void> loginWithSpotify() async {
    try {
      await _account.createOAuth2Session(
        provider: 'spotify',
        success: AppwriteConfig.successUrl,
        failure: AppwriteConfig.failureUrl,
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
      return false;
    }
  }

  // Create user profile for first-time users
  Future<AuraData> createUserProfile(String userId, String displayName, String? email, String? profileImageUrl) async {
    try {
      final session = await _account.getSession(sessionId: 'current');
      final accessToken = session.providerAccessToken;

      if (accessToken.isEmpty) {
        throw AppwriteException('No access token available');
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
        throw AppwriteException('No access token available');
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
        throw AppwriteException('No access token available');
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
