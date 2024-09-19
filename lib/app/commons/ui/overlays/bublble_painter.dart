import 'package:flutter/material.dart';

class CustomChatBubblePainter extends CustomPainter {
  final bool isSentByMe;
  final Color color;

  CustomChatBubblePainter({required this.isSentByMe, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final bubblePath = Path();
    const radius = 16.0; // Rounded corner radius
    const tailWidth = 10.0;
    const tailHeight = 16.0;

    if (isSentByMe) {
      bubblePath.moveTo(radius, 0);
      bubblePath.lineTo(size.width - radius, 0);
      bubblePath.arcToPoint(Offset(size.width, radius),
          radius: const Radius.circular(radius));
      bubblePath.lineTo(size.width, size.height - radius - tailHeight);
      bubblePath.arcToPoint(
          Offset(size.width - radius, size.height - tailHeight),
          radius: const Radius.circular(radius));
      bubblePath.lineTo(size.width - tailWidth, size.height - tailHeight);
      bubblePath.lineTo(size.width - radius - tailWidth, size.height);
      bubblePath.arcToPoint(
          Offset(size.width - radius - tailWidth * 2,
              size.height - radius - tailHeight),
          radius: const Radius.circular(radius));
      bubblePath.lineTo(radius, size.height - tailHeight);
      bubblePath.arcToPoint(Offset(0, size.height - radius - tailHeight),
          radius: const Radius.circular(radius));
      bubblePath.lineTo(0, radius);
      bubblePath.arcToPoint(const Offset(radius, 0),
          radius: const Radius.circular(radius));
    } else {
      bubblePath.moveTo(size.width - radius, 0);
      bubblePath.lineTo(radius, 0);
      bubblePath.arcToPoint(const Offset(0, radius),
          radius: const Radius.circular(radius));
      bubblePath.lineTo(0, size.height - radius - tailHeight);
      bubblePath.arcToPoint(Offset(radius, size.height - tailHeight),
          radius: const Radius.circular(radius));
      bubblePath.lineTo(tailWidth, size.height - tailHeight);
      bubblePath.lineTo(radius + tailWidth, size.height);
      bubblePath.arcToPoint(
          Offset(radius * 2 + tailWidth, size.height - radius - tailHeight),
          radius: const Radius.circular(radius));
      bubblePath.lineTo(size.width - radius, size.height - tailHeight);
      bubblePath.arcToPoint(
          Offset(size.width, size.height - radius - tailHeight),
          radius: const Radius.circular(radius));
      bubblePath.lineTo(size.width, radius);
      bubblePath.arcToPoint(Offset(size.width - radius, 0),
          radius: const Radius.circular(radius));
    }

    canvas.drawPath(bubblePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
