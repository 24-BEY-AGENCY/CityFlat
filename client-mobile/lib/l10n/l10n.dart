import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('de'), // German
    const Locale('en'), // English
    const Locale('fr'), // French
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'de':
        return '🇩🇪';
      case 'en':
        return '🇺🇸';
      case 'fr':
        return '🇫🇷';
      default:
        return '🏳️';
    }
  }
}
