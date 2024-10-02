import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  // Priority determines the order of middleware execution. Lower numbers have higher priority.
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // Check if the user is authenticated
    final user = FirebaseAuth.instance.currentUser;

    if (user == null && route != Routes.AUTH) {
      return const RouteSettings(name: Routes.AUTH);
    }

    if (user != null && route == Routes.AUTH) {
      return const RouteSettings(name: Routes.CORE);
    }
    return null;
  }
}
