import 'package:cityflat/l10n/l10n.dart';
import 'package:cityflat/providers/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  @override
  Widget build(BuildContext context) {
    final localizationProvider =
        Provider.of<LocalizationProvider>(context, listen: false);
    return DropdownButtonHideUnderline(
        child: DropdownButton(
      value: localizationProvider.locale,
      icon: Container(
        width: 20.0,
      ),
      items: L10n.all.map((locale) {
        final flag = L10n.getFlag(locale.languageCode);

        return DropdownMenuItem(
          child: Center(
            child: Text(flag),
          ),
          value: locale,
          onTap: () {
            localizationProvider.setLocale(locale);
          },
        );
      }).toList(),
      onChanged: (_) {},
    ));
  }
}
