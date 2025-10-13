import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/app_state.dart';
import 'services/app_state_service.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'utils/error_handler.dart';

void main() {
  runApp(const AuraTuneApp());
}

class AuraTuneApp extends StatelessWidget {
  const AuraTuneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppStateService(),
      child: MaterialApp(
        title: 'AuraTune - Discover Your Musical DNA',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF1E2A27),
          primaryColor: const Color(0xFF2B3F3A),
          textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF1DB954),
            secondary: Color(0xFF2B3F3A),
            surface: Color(0xFF2B3F3A),
            onSurface: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          cardTheme: CardThemeData(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        home: const AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    // Initialize the app state service
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppStateService>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateService>(
      builder: (context, appStateService, child) {
        final state = appStateService.state;

        // Show error messages
        if (state.hasError && state.errorMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ErrorHandler.showError(context, state.errorMessage!);
            appStateService.clearError();
          });
        }

        // Show loading state during initialization
        if (!state.isInitialized) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Initializing AuraTune...',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Show login screen if not authenticated
        if (state.authState == AuthState.unauthenticated) {
          return LoginScreen(
            onLogin: () => appStateService.login(),
            isLoading: state.authState == AuthState.loading,
          );
        }

        // Show home screen if authenticated
        if (state.authState == AuthState.authenticated) {
          return HomeScreen(
            appState: state,
            onLogout: () => appStateService.logout(),
            onRetryAnalysis: () => appStateService.retryAnalysis(),
          );
        }

        // Fallback loading state
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}