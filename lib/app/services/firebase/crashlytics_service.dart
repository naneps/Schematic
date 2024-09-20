import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A service class for handling Crashlytics functionality.
class CrashlyticsService extends GetxService {
  static CrashlyticsService get to => Get.find();

  Future<CrashlyticsService> init() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack);
      return true;
    };

    return this;
  }

  void log(String message) {
    FirebaseCrashlytics.instance.log(message);
  }

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void recordError(CrashRecord record) {
    FirebaseCrashlytics.instance.recordError(
      record.exception,
      record.stack,
      reason: record.reason,
      information: record.information.map((e) => e.toString()).toList(),
      fatal: record.fatal,
    );
    // custom key-value pairs
  }

  /// Simulates a crash for testing purposes.
  void simulateCrash() {
    FirebaseCrashlytics.instance.crash();
  }
}

class CrashRecord {
  dynamic exception;
  StackTrace? stack;
  dynamic reason;
  Iterable<Object> information = const [];
  bool? printDetails;
  bool fatal = false;

  CrashRecord({
    required this.exception,
    this.stack,
    this.reason,
    this.information = const [],
    this.printDetails,
    this.fatal = false,
  });
}
