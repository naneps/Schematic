import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;
  final EdgeInsetsGeometry? padding;

  const ResponsiveLayout({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Check if the device is in portrait mode
    bool isPortrait = orientation == Orientation.portrait;

    // Determine which layout to use based on screen width
    Widget currentChild;
    if (screenWidth < 600) {
      currentChild = mobile ?? Container();
    } else if (screenWidth < 1200) {
      currentChild = tablet ?? mobile ?? Container();
    } else {
      currentChild = desktop ?? tablet ?? mobile ?? Container();
    }

    // If landscape mode, prioritize width for desktop layout
    if (!isPortrait && screenWidth >= 1024) {
      currentChild = desktop ?? tablet ?? mobile ?? Container();
    }

    // You could also add more custom handling based on height,
    // such as adjusting padding or layout for very tall/short screens
    double responsivePadding = screenHeight > 800
        ? 16.0
        : 8.0; // Example: Adjust padding based on screen height

    return Padding(
      padding: padding ?? EdgeInsets.all(responsivePadding),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        switchInCurve: Curves.easeInOutCubic,
        child: currentChild,
      ),
    );
  }
}
