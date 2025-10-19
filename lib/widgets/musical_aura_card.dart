import 'package:flutter/material.dart';
import '../models/aura_data.dart';
import '../utils/responsive_helper.dart';
import 'aura_radar_chart.dart';

class MusicalAuraCard extends StatelessWidget {
  final AuraData auraData;

  const MusicalAuraCard({super.key, required this.auraData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildChart(context),
            const SizedBox(height: 24),
            _buildOverallScore(context),
            const SizedBox(height: 24),
            _buildPersonalitySection(context),
            const SizedBox(height: 24),
            _buildTraitGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.auto_graph,
          color: Theme.of(context).colorScheme.primary,
          size: 28,
        ),
        const SizedBox(width: 12),
        Text(
          'Your Musical Aura',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 24),
          ),
        ),
      ],
    );
  }

  Widget _buildChart(BuildContext context) {
    return ResponsiveLayout(
      mobile: SizedBox(
        height: 280,
        child: AuraRadarChart(values: auraData.auraVector),
      ),
      tablet: SizedBox(
        height: 320,
        child: AuraRadarChart(values: auraData.auraVector),
      ),
      desktop: SizedBox(
        height: 360,
        child: AuraRadarChart(values: auraData.auraVector),
      ),
    );
  }

  Widget _buildOverallScore(BuildContext context) {
    final overallScore = auraData.overallScore.round();
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Overall Musical Score',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$overallScore%',
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 48),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'This radar chart visualizes your musical aura based on your listening history. Each axis represents a different musical attribute.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              height: 1.5,
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalitySection(BuildContext context) {
    final personality = PersonalityType.fromName(auraData.auraPersonality);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
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
              Text(
                'Musical Personality',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            personality.name,
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 20),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            personality.description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTraitGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detailed Traits',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        AuraTraitGrid(values: auraData.auraVector),
      ],
    );
  }
}
