import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:schematic/app/main_app.dart';
import 'package:schematic/app/services/app_translation.dart';
import 'package:schematic/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await dotenv.load(fileName: ".env");
  }
  AppTranslations appTranslations = AppTranslations();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await appTranslations.load();
  runApp(MainApp(translations: appTranslations));
}
