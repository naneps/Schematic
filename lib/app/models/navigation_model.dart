import 'package:flutter/material.dart';

class NavigationModel {
  final String? title;
  final String? icon;
  final String? route;
  final IconData? iconData;
  String? badge;
  NavigationModel({
    this.title,
    this.icon,
    this.route,
    this.iconData,
    this.badge = '',
  });
}
