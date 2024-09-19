import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class XErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final String? err;
  const XErrorWidget({
    super.key,
    this.onRetry,
    this.err,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/error.png'),
          Text(
            err!,
            style: Get.textTheme.labelLarge!.copyWith(
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: () => onRetry?.call(),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(Get.width, 40),
            ),
            icon: Icon(MdiIcons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
