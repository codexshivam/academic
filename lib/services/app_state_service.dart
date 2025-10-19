import 'package:flutter/foundation.dart';
import '../models/app_state.dart';
import 'appwrite_service.dart';

class AppStateService extends ChangeNotifier {
  AppState _state = const AppState();
  final AppwriteService _appwriteService = AppwriteService();

  AppState get state => _state;

  void _updateState(AppState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> initialize() async {
    _updateState(_state.copyWith(
      authState: AuthState.loading,
      isInitialized: false,
    ));

    try {
      _appwriteService.initialize();
      await _checkAuthStatus();
    } catch (e) {
      _updateState(_state.copyWith(
        authState: AuthState.error,
        errorMessage: 'Failed to initialize app: $e',
      ));
    }
  }

  Future<void> _checkAuthStatus() async {
    try {
      final user = await _appwriteService.getCurrentUser();
      
      if (user != null) {
        _updateState(_state.copyWith(
          authState: AuthState.authenticated,
          isInitialized: true,
          errorMessage: null,
        ));
        
        // Automatically fetch aura data after authentication
        await _fetchOrAnalyzeAura(user.$id, user.name, email: user.email, profileImageUrl: null);
      } else {
        _updateState(_state.copyWith(
          authState: AuthState.unauthenticated,
          isInitialized: true,
          errorMessage: null,
        ));
      }
    } catch (e) {
      _updateState(_state.copyWith(
        authState: AuthState.error,
        errorMessage: 'Failed to check authentication: $e',
        isInitialized: true,
      ));
    }
  }

  Future<void> login() async {
    try {
      await _appwriteService.loginWithSpotify();
      await _checkAuthStatus();
    } catch (e) {
      _updateState(_state.copyWith(
        authState: AuthState.error,
        errorMessage: 'Login failed: $e',
      ));
    }
  }

  Future<void> logout() async {
    try {
      await _appwriteService.logout();
      _updateState(const AppState(
        authState: AuthState.unauthenticated,
        isInitialized: true,
      ));
    } catch (e) {
      _updateState(_state.copyWith(
        errorMessage: 'Logout failed: $e',
      ));
    }
  }

  Future<void> _fetchOrAnalyzeAura(String userId, String displayName, {String? email, String? profileImageUrl}) async {
    try {
      _updateState(_state.copyWith(
        analysisState: AnalysisState.analyzing,
        errorMessage: null,
      ));

      // Check if user profile exists
      final profileExists = await _appwriteService.userProfileExists(userId);
      
      if (profileExists) {
        // Returning user - update existing profile and refresh aura data
        debugPrint('🎵 Returning user detected, updating profile...');
        final updatedAuraData = await _appwriteService.updateUserProfile(userId, displayName);
        
        _updateState(_state.copyWith(
          analysisState: AnalysisState.completed,
          auraData: updatedAuraData,
          errorMessage: null,
        ));
      } else {
        // First-time user - create new profile
        debugPrint('🎉 First-time user detected, creating profile...');
        final newAuraData = await _appwriteService.createUserProfile(userId, displayName, email, profileImageUrl);
        
        _updateState(_state.copyWith(
          analysisState: AnalysisState.completed,
          auraData: newAuraData,
          errorMessage: null,
        ));
      }
    } catch (e) {
      final errorMessage = e.toString().contains('Failed to') 
          ? e.toString() 
          : 'Failed to process user: $e';
          
      _updateState(_state.copyWith(
        analysisState: AnalysisState.error,
        errorMessage: errorMessage,
      ));
    }
  }

  Future<void> retryAnalysis() async {
    if (_state.isAuthenticated) {
      final user = await _appwriteService.getCurrentUser();
      if (user != null) {
        await _fetchOrAnalyzeAura(user.$id, user.name, email: user.email, profileImageUrl: null);
      }
    }
  }

  void clearError() {
    _updateState(_state.copyWith(errorMessage: null));
  }
}
