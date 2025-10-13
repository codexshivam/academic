import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onLogin;
  final bool isLoading;

  const LoginScreen({
    super.key,
    required this.onLogin,
    this.isLoading = false,
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
          child: Center(
            child: SingleChildScrollView(
              padding: ResponsiveHelper.getResponsiveEdgeInsets(context),
              child: ResponsiveLayout(
                mobile: _buildMobileLayout(context),
                tablet: _buildTabletLayout(context),
                desktop: _buildDesktopLayout(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogo(context),
        const SizedBox(height: 48),
        _buildWelcomeText(context),
        const SizedBox(height: 32),
        _buildLoginButton(context),
        const SizedBox(height: 32),
        _buildFeatures(context),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(context),
              const SizedBox(height: 48),
              _buildWelcomeText(context),
              const SizedBox(height: 32),
              _buildLoginButton(context),
            ],
          ),
        ),
        const SizedBox(width: 48),
        Expanded(
          child: _buildFeatures(context),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(context),
              const SizedBox(height: 48),
              _buildWelcomeText(context),
              const SizedBox(height: 32),
              _buildLoginButton(context),
            ],
          ),
        ),
        const SizedBox(width: 64),
        Expanded(
          flex: 3,
          child: _buildFeatures(context),
        ),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Icon(
            Icons.music_note,
            size: ResponsiveHelper.getResponsiveFontSize(context, 48),
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'AuraTune',
          style: TextStyle(
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 36),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return Column(
      children: [
        Text(
          'Discover Your Musical DNA',
          style: TextStyle(
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 28),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Connect with Spotify and unlock insights into your musical personality through AI-powered analysis.',
          style: TextStyle(
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 18),
            color: Colors.white.withOpacity(0.8),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onLogin,
        icon: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Icon(Icons.music_note),
        label: Text(
          isLoading ? 'Connecting...' : 'Login with Spotify',
          style: TextStyle(
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 18),
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8,
          shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildFeatures(BuildContext context) {
    final features = [
      _FeatureItem(
        icon: Icons.analytics,
        title: 'AI Analysis',
        description: 'Advanced algorithms analyze your musical preferences',
      ),
      _FeatureItem(
        icon: Icons.radar,
        title: 'Visual Aura',
        description: 'Beautiful radar charts show your musical personality',
      ),
      _FeatureItem(
        icon: Icons.psychology,
        title: 'Personality Insights',
        description: 'Discover your unique musical personality type',
      ),
      _FeatureItem(
        icon: Icons.security,
        title: 'Secure & Private',
        description: 'Your data is encrypted and never shared',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Why Choose AuraTune?',
          style: TextStyle(
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 24),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        ...features.map((feature) => _buildFeatureItem(context, feature)),
      ],
    );
  }

  Widget _buildFeatureItem(BuildContext context, _FeatureItem feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              feature.icon,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feature.description,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
