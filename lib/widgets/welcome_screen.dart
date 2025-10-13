import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onContinue;
  final bool isFirstTime;
  final String userName;

  const WelcomeScreen({
    super.key,
    required this.onContinue,
    required this.isFirstTime,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Welcome Animation
                  _buildWelcomeAnimation(context, isMobile),
                  
                  SizedBox(height: isMobile ? 30 : 50),
                  
                  // Welcome Message
                  _buildWelcomeMessage(context, isMobile),
                  
                  SizedBox(height: isMobile ? 30 : 50),
                  
                  // Features Overview
                  if (isFirstTime) _buildFeaturesOverview(context, isMobile),
                  
                  SizedBox(height: isMobile ? 40 : 60),
                  
                  // Continue Button
                  _buildContinueButton(context, isMobile),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeAnimation(BuildContext context, bool isMobile) {
    return Container(
      width: isMobile ? 200 : 300,
      height: isMobile ? 200 : 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Colors.transparent,
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: isMobile ? 100 : 150,
          height: isMobile ? 100 : 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Icon(
            Icons.music_note,
            size: isMobile ? 50 : 80,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage(BuildContext context, bool isMobile) {
    return Column(
      children: [
        Text(
          isFirstTime ? 'Welcome to AuraTune!' : 'Welcome back!',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        Text(
          isFirstTime 
              ? 'Hi $userName! We\'re about to discover your unique musical DNA.'
              : 'Hi $userName! Let\'s update your musical aura with your latest listening habits.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: isMobile ? 16 : 18,
            color: Colors.white.withOpacity(0.8),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFeaturesOverview(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Text(
            'What we\'ll analyze:',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildFeatureItem(
            context,
            Icons.analytics,
            'Your Top Tracks',
            'Recent and long-term favorites',
          ),
          _buildFeatureItem(
            context,
            Icons.psychology,
            'Musical Traits',
            'Energy, danceability, and mood',
          ),
          _buildFeatureItem(
            context,
            Icons.person,
            'Personality Profile',
            'Your unique musical personality',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context, bool isMobile) {
    return ElevatedButton.icon(
      onPressed: onContinue,
      icon: const Icon(Icons.arrow_forward),
      label: Text(isFirstTime ? 'Discover My Musical Aura' : 'Update My Aura'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 30 : 40,
          vertical: isMobile ? 15 : 20,
        ),
        textStyle: TextStyle(fontSize: isMobile ? 18 : 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
      ),
    );
  }
}
