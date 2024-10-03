import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:schematic/app/commons/ui/loading.widget.dart';
import 'package:schematic/app/commons/ui/overlays/scale_dialog.dart';

class LoadingDialog extends StatefulWidget {
  final String? message;

  const LoadingDialog({super.key, this.message});

  @override
  _LoadingDialogState createState() => _LoadingDialogState();

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void show(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ScaleDialog(child: LoadingDialog(message: message)),
    );
  }
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 150,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const LoadingWidget(),
          ),
        ),
      ),
    );
  }
}
