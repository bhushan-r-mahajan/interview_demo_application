import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;
  String language = '';

  void setLocale(Locale locale, String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language", language);
    var lang = prefs.getString("language");
    if (lang != null) this.language = lang;
    _locale = locale;
    notifyListeners();
  }

  void checkLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var language = prefs.getString("language");
    if (language != null && language == "arabic") {
      this.language = language;
      _locale = const Locale('ar');
    } else {
      this.language = language!;
      _locale = const Locale('en');
    }
    notifyListeners();
  }
}
