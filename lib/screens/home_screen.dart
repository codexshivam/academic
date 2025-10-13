import 'package:flutter/material.dart';
import '../models/app_state.dart';
import '../models/aura_data.dart';
import '../utils/responsive_helper.dart';
import '../utils/error_handler.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/musical_aura_card.dart';
import '../widgets/technology_card.dart';

class HomeScreen extends StatelessWidget {
  final AppState appState;
  final VoidCallback onLogout;
  final VoidCallback onRetryAnalysis;

  const HomeScreen({
    super.key,
    required this.appState,
    required this.onLogout,
    required this.onRetryAnalysis,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1E2A27),
              const Color(0xFF2B3F3A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                userName: appState.auraData?.displayName ?? 'User',
                onLogout: onLogout,
                onRetry: appState.hasError ? onRetryAnalysis : null,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: ResponsiveHelper.getResponsiveEdgeInsets(context),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      _buildMainContent(context),
                      const SizedBox(height: 32),
                      const TechnologyCard(),
                      const SizedBox(height: 32),
                      _buildFooter(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    if (appState.isLoading) {
      return _buildLoadingState(context);
    }

    if (appState.hasError) {
      return _buildErrorState(context);
    }

    if (appState.hasAuraData && appState.auraData != null) {
      return _buildAuraDataDisplay(context, appState.auraData!);
    }

    return _buildWelcomeState(context);
  }

  Widget _buildLoadingState(BuildContext context) {
    return Column(
      children: [
        ErrorHandler.loadingWidget(
          message: appState.analysisState == AnalysisState.analyzing
              ? 'Analyzing your musical aura...'
              : 'Loading your profile...',
        ),
        const SizedBox(height: 24),
        _buildLoadingInfo(context),
      ],
    );
  }

  Widget _buildLoadingInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.analytics,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Analyzing Your Music',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'We\'re analyzing your Spotify listening history to create your unique musical aura. This may take a few moments...',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return ErrorHandler.errorWidget(
      message: appState.errorMessage ?? 'An unexpected error occurred',
      onRetry: onRetryAnalysis,
      retryText: 'Retry Analysis',
    );
  }

  Widget _buildWelcomeState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.music_note,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'Welcome to Your Musical Journey!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Your musical aura analysis is being prepared. This will give you deep insights into your musical personality and preferences.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAuraDataDisplay(BuildContext context, AuraData auraData) {
    return ResponsiveLayout(
      mobile: Column(
        children: [
          MusicalAuraCard(auraData: auraData),
        ],
      ),
      tablet: Column(
        children: [
          MusicalAuraCard(auraData: auraData),
        ],
      ),
      desktop: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: MusicalAuraCard(auraData: auraData),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 4,
            child: _buildSidePanel(context, auraData),
          ),
        ],
      ),
    );
  }

  Widget _buildSidePanel(BuildContext context, AuraData auraData) {
    return Column(
      children: [
        _buildQuickStats(context, auraData),
        const SizedBox(height: 24),
        _buildPersonalityCard(context, auraData),
        const SizedBox(height: 24),
        _buildShareCard(context),
      ],
    );
  }

  Widget _buildQuickStats(BuildContext context, AuraData auraData) {
    final overallScore = auraData.overallScore.round();
    
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Quick Stats',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(context, 'Overall', '$overallScore%', Icons.trending_up),
                _buildStatItem(context, 'Traits', '${auraData.auraVector.length}', Icons.analytics),
                _buildStatItem(context, 'Updated', 'Recent', Icons.update),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalityCard(BuildContext context, AuraData auraData) {
    final personality = PersonalityType.fromName(auraData.auraPersonality);
    
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  personality.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your Personality',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              personality.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              personality.description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareCard(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.share,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              'Share Your Aura',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Share your musical personality with friends and discover their musical auras too!',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sharing feature coming soon!')),
                  );
                },
                icon: const Icon(Icons.share, size: 16),
                label: const Text('Share'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  side: BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Text(
        '© 2025 AuraTune. Discover your musical DNA.',
        style: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 14,
        ),
      ),
    );
  }
}
