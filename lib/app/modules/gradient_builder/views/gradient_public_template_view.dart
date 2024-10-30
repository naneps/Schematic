import 'package:flutter/material.dart';
import 'package:schematic/app/commons/ui/responsive_layout.dart';

class GradientPublicView extends StatelessWidget {
  const GradientPublicView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
        mobile: Column(),
        tablet: Row(
          children: [],
        ),
      ),
    );
  }
}
