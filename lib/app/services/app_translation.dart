import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class AppTranslations extends Translations {
  final Map<String, Map<String, String>> _localizedValues = {};

  @override
  Map<String, Map<String, String>> get keys => _localizedValues;

  Future<void> load() async {
    String enJson = await rootBundle.loadString('assets/lang/en_us.json');
    String idJson = await rootBundle.loadString('assets/lang/id_id.json');
    String koJson = await rootBundle.loadString('assets/lang/ko_kr.json');
    _localizedValues['en_US'] = Map<String, String>.from(json.decode(enJson));
    _localizedValues['id_ID'] = Map<String, String>.from(json.decode(idJson));
    _localizedValues['ko_KR'] = Map<String, String>.from(json.decode(koJson));
  }

  Future<void> loadFromGoogleTranslate() async {}
}
