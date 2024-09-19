import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScaleDialog extends StatefulWidget {
  final Widget child;

  const ScaleDialog({super.key, required this.child});

  @override
  _ScaleDialogState createState() => _ScaleDialogState();
}

class _ScaleDialogState extends State<ScaleDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _controller.reverse();
        return true;
      },
      child: ScaleTransition(scale: _animation, child: widget.child),
    );
  }

  void closeDialog() async {
    await _controller.reverse();
    Get.back();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    );
    _controller.forward();
  }
}
