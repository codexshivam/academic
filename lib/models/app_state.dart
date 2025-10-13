import 'aura_data.dart';

enum AuthState {
  loading,
  authenticated,
  unauthenticated,
  error,
}

enum AnalysisState {
  idle,
  analyzing,
  completed,
  error,
}

class AppState {
  final AuthState authState;
  final AnalysisState analysisState;
  final String? errorMessage;
  final AuraData? auraData;
  final bool isInitialized;

  const AppState({
    this.authState = AuthState.loading,
    this.analysisState = AnalysisState.idle,
    this.errorMessage,
    this.auraData,
    this.isInitialized = false,
  });

  AppState copyWith({
    AuthState? authState,
    AnalysisState? analysisState,
    String? errorMessage,
    AuraData? auraData,
    bool? isInitialized,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      analysisState: analysisState ?? this.analysisState,
      errorMessage: errorMessage ?? this.errorMessage,
      auraData: auraData ?? this.auraData,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  bool get isLoading => authState == AuthState.loading || analysisState == AnalysisState.analyzing;
  bool get hasError => authState == AuthState.error || analysisState == AnalysisState.error;
  bool get isAuthenticated => authState == AuthState.authenticated;
  bool get hasAuraData => auraData != null && analysisState == AnalysisState.completed;
}
