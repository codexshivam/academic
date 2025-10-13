import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';

class CustomAppBar extends StatelessWidget {
  final String userName;
  final VoidCallback onLogout;
  final VoidCallback? onRetry;

  const CustomAppBar({
    super.key,
    required this.userName,
    required this.onLogout,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveHelper.getResponsiveEdgeInsets(context),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: ResponsiveLayout(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogo(context),
            _buildUserMenu(context),
          ],
        ),
        if (onRetry != null) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: _buildRetryButton(context),
          ),
        ],
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(context),
        Row(
          children: [
            if (onRetry != null) _buildRetryButton(context),
            const SizedBox(width: 16),
            _buildUserMenu(context),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(context),
        Row(
          children: [
            _buildNavLinks(context),
            const SizedBox(width: 32),
            if (onRetry != null) ...[
              _buildRetryButton(context),
              const SizedBox(width: 16),
            ],
            _buildUserMenu(context),
          ],
        ),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.music_note, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Text(
          'Music Aura',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 20),
          ),
        ),
      ],
    );
  }

  Widget _buildNavLinks(BuildContext context) {
    return Row(
      children: [
        _navLink('Home', context),
        _navLink('About', context),
        _navLink('Contact', context),
      ],
    );
  }

  Widget _navLink(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: () {
          // Handle navigation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title navigation coming soon!')),
          );
        },
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
          ),
        ),
      ),
    );
  }

  Widget _buildUserMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'logout') {
          onLogout();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'user',
          child: Text('Hi, $userName'),
          enabled: false,
        ),
        const PopupMenuItem<String>(
          value: 'logout',
          child: Text('Logout'),
        ),
      ],
      child: _iconButton(Icons.person),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onRetry,
      icon: const Icon(Icons.refresh, size: 16),
      label: const Text('Retry Analysis'),
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}
