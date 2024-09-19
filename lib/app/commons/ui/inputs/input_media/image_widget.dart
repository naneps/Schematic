import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schematic/app/commons/ui/buttons/x_icon_button.dart';
import 'package:schematic/app/commons/ui/shapes/dotted_border.dart';

class ImageWidget extends StatelessWidget {
  final XFile media;
  final onDeleted;
  final bool canPreview;
  const ImageWidget({
    super.key,
    required this.media,
    required this.onDeleted,
    this.canPreview = false,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(5),
      child: InkWell(
        onTap: () {
          if (canPreview) {
            Get.dialog(
              Dialog(
                child: Image.file(
                  File(media.path),
                  fit: BoxFit.fill,
                ),
              ),
            );
          }
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 50,
              margin: const EdgeInsets.only(right: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade200,
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.file(
                File(media.path),
                fit: BoxFit.fill,
                width: 50,
              ),
            ),
            Positioned(
              top: -5,
              right: -5,
              child: XIconButton.filled(
                icon: FontAwesomeIcons.circleXmark,
                size: 15,
                iconSize: 10,
                padding: const EdgeInsets.all(0),
                borderRadius: 15,
                color: Colors.red,
                backgroundColor: Colors.white,
                onPressed: () {
                  onDeleted();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
