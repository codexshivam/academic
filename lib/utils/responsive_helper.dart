import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 768 && width < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static bool isLargeDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1440;
  }

  static double getResponsivePadding(BuildContext context) {
    if (isMobile(context)) return 16.0;
    if (isTablet(context)) return 24.0;
    if (isDesktop(context)) return 32.0;
    return 40.0;
  }

  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    if (isMobile(context)) return baseSize * 0.9;
    if (isTablet(context)) return baseSize;
    if (isDesktop(context)) return baseSize * 1.1;
    return baseSize * 1.2;
  }

  static int getResponsiveColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }

  static double getCardWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final padding = getResponsivePadding(context) * 2;
    
    if (isMobile(context)) {
      return width - padding;
    } else if (isTablet(context)) {
      return (width - padding * 2) / 2;
    } else {
      return (width - padding * 3) / 2;
    }
  }

  static EdgeInsets getResponsiveEdgeInsets(BuildContext context) {
    final padding = getResponsivePadding(context);
    return EdgeInsets.symmetric(
      horizontal: padding,
      vertical: padding * 0.5,
    );
  }

  static Widget responsiveBuilder({
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
    required BuildContext context,
  }) {
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.responsiveBuilder(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}
