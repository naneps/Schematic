import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';

class CornerBordersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ThemeManager().primaryColor
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.2, 0)
      ..moveTo(0, 0)
      ..lineTo(0, size.height * 0.2)
      ..moveTo(size.width, 0)
      ..lineTo(size.width * 0.8, 0)
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.2)
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.8)
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.2, size.height)
      ..moveTo(size.width, size.height)
      ..lineTo(size.width * 0.8, size.height)
      ..moveTo(size.width, size.height)
      ..lineTo(size.width, size.height * 0.8);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CornerBordersPainter oldDelegate) => false;
}

class ScanningAnimation extends StatefulWidget {
  const ScanningAnimation({super.key});

  @override
  _ScanningAnimationState createState() => _ScanningAnimationState();
}

class _ScanningAnimationState extends State<ScanningAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: CornerBordersPainter(),
            ),
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              double topPosition =
                  _animation.value * (MediaQuery.of(context).size.height - 60);
              double bottomPosition = (1.0 - _animation.value) *
                  (MediaQuery.of(context).size.height - 60);

              return Stack(
                children: [
                  Positioned(
                    top: topPosition,
                    left: 0,
                    right: 0,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 3),
                      width: double.infinity,
                      height: Get.height,
                      decoration: BoxDecoration(
                        color: ThemeManager().primaryColor,
                        gradient: LinearGradient(
                          colors: [
                            ThemeManager().primaryColor.withOpacity(0.0),
                            ThemeManager().primaryColor.withOpacity(0.0),
                            ThemeManager().primaryColor,
                            ThemeManager().primaryColor.withOpacity(0.0),
                            ThemeManager().primaryColor.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: bottomPosition,
                    left: 0,
                    right: 0,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 3),
                      width: double.infinity,
                      height: Get.height,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          ThemeManager().primaryColor.withOpacity(0.0),
                          ThemeManager().primaryColor.withOpacity(0.0),
                          ThemeManager().primaryColor,
                          ThemeManager().primaryColor.withOpacity(0.0),
                          ThemeManager().primaryColor.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }
}
