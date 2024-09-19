import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LangSwitcher extends StatefulWidget {
  final void Function(Locale)? onLanguageChanged;
  const LangSwitcher({
    super.key,
    this.onLanguageChanged,
  });

  @override
  State<LangSwitcher> createState() => LangSwitcherState();
}

class LangSwitcherState extends State<LangSwitcher> {
  Language? initialLanguage;
  List<Language> languages = [
    Language(
      code: 'en_US',
      name: 'English',
      flag: '🇺🇸',
    ),
    Language(
      code: 'id_ID',
      name: 'Indonesian',
      flag: '🇮🇩',
    ),
    Language(
      code: 'ko_KR',
      name: 'Korean',
      flag: '🇰🇷',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Language>(
      value: initialLanguage,
      onChanged: (Language? language) {
        if (language != null) {
          setState(() {
            initialLanguage = language;
          });
          // Update locale
          Locale newLocale = Locale(
            language.code.split('_')[0],
            language.code.split('_')[1],
          );
          Get.updateLocale(newLocale);

          if (widget.onLanguageChanged != null) {
            widget.onLanguageChanged!(newLocale);
          }
        }
      },
      items: languages
          .map(
            (Language language) => DropdownMenuItem<Language>(
              value: language,
              child: Row(
                children: <Widget>[
                  Text(language.flag ?? ''),
                  const SizedBox(width: 10),
                  Text(language.name),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    // Initialize language from locale
    final Locale locale = Get.locale ?? const Locale('en', 'US');
    initialLanguage = languages.firstWhere(
      (language) => language.code == locale.toString(),
      orElse: () => languages[0],
    );
  }
}

class Language {
  final String code;
  final String name;
  final String? flag;
  final IconData? icon;
  Language({
    required this.code,
    required this.name,
    this.flag,
    this.icon,
  });
}
