import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/models/navigation_model.dart';

class NavigationTile extends StatelessWidget {
  final NavigationModel item;
  final void Function()? onTap;
  final bool isActive;
  final String? badge;
  const NavigationTile({
    super.key,
    required this.item,
    this.onTap,
    this.isActive = false,
    this.badge = '',
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
          color: isActive ? ThemeManager().backgroundColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            left: BorderSide(
              color: isActive ? ThemeManager().primaryColor : Colors.white,
              width: 5,
            ),
            right: BorderSide(
              color: isActive ? ThemeManager().primaryColor : Colors.white,
              width: 1,
            ),
            top: BorderSide(
              color: isActive ? ThemeManager().primaryColor : Colors.white,
              width: 1,
            ),
            bottom: BorderSide(
              color: isActive ? ThemeManager().primaryColor : Colors.white,
              width: 2,
            ),
          ),
          boxShadow: [
            ThemeManager().defaultShadow(
              color: isActive ? ThemeManager().primaryColor : Colors.white,
            ),
          ]),
      child: ListTile(
          leading: Icon(
            item.iconData,
          ),
          dense: true,
          visualDensity: VisualDensity.compact,
          title: Text(
            item.title!,
            style: Get.textTheme.labelMedium!.copyWith(),
          ),
          onTap: onTap,
          trailing: badge!.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: ThemeManager().primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    badge!,
                    style: Get.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                )
              : null),
    );
  }
}
