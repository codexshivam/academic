import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';

class TechnologyCard extends StatelessWidget {
  const TechnologyCard({super.key});

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
            const SizedBox(height: 16),
            _buildDescription(context),
            const SizedBox(height: 32),
            _buildCorePackages(context),
            const SizedBox(height: 32),
            _buildMachineLearning(context),
            const SizedBox(height: 32),
            _buildTechStack(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.code,
          color: Theme.of(context).colorScheme.primary,
          size: 28,
        ),
        const SizedBox(width: 12),
        Text(
          'Technology Behind the Aura',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 22),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      'This application leverages several powerful technologies to analyze your music and generate your aura.',
      style: TextStyle(
        color: Colors.white.withOpacity(0.7),
        height: 1.5,
        fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
      ),
    );
  }

  Widget _buildCorePackages(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Core Packages',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _technologyItem(
          context,
          'numpy',
          'Used for numerical computations and efficient array manipulation.',
          Icons.calculate,
        ),
        _technologyItem(
          context,
          'pandas',
          'Employed for data manipulation and analysis, particularly with structured dataframes.',
          Icons.table_chart,
        ),
        _technologyItem(
          context,
          'spotipy',
          'Python library for accessing the Spotify Web API to fetch user music data.',
          Icons.music_note,
        ),
        _technologyItem(
          context,
          'appwrite-sdk',
          'Provides seamless integration with Appwrite backend services.',
          Icons.cloud,
        ),
      ],
    );
  }

  Widget _buildMachineLearning(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Music Analysis',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.psychology,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'AI-Powered Analysis',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Machine learning algorithms analyze audio features like energy, happiness, and danceability. These features are extracted from your listening data to create a personalized musical aura profile.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  height: 1.5,
                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTechStack(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Stack',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ResponsiveLayout(
          mobile: _buildTechStackMobile(context),
          tablet: _buildTechStackTablet(context),
          desktop: _buildTechStackDesktop(context),
        ),
      ],
    );
  }

  Widget _buildTechStackMobile(BuildContext context) {
    return Column(
      children: [
        _techStackItem(context, 'Frontend', 'Flutter Web', Icons.web),
        _techStackItem(context, 'Backend', 'Appwrite Cloud', Icons.cloud),
        _techStackItem(context, 'Functions', 'Python 3.10', Icons.functions),
        _techStackItem(context, 'Database', 'Appwrite NoSQL', Icons.storage),
      ],
    );
  }

  Widget _buildTechStackTablet(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _techStackItem(context, 'Frontend', 'Flutter Web', Icons.web),
        _techStackItem(context, 'Backend', 'Appwrite Cloud', Icons.cloud),
        _techStackItem(context, 'Functions', 'Python 3.10', Icons.functions),
        _techStackItem(context, 'Database', 'Appwrite NoSQL', Icons.storage),
      ],
    );
  }

  Widget _buildTechStackDesktop(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: 2.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _techStackItem(context, 'Frontend', 'Flutter Web', Icons.web),
        _techStackItem(context, 'Backend', 'Appwrite Cloud', Icons.cloud),
        _techStackItem(context, 'Functions', 'Python 3.10', Icons.functions),
        _techStackItem(context, 'Database', 'Appwrite NoSQL', Icons.storage),
      ],
    );
  }

  Widget _technologyItem(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _techStackItem(
    BuildContext context,
    String category,
    String technology,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            category,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 12),
            ),
          ),
          Text(
            technology,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
