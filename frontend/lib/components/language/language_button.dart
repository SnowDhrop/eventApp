import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:frontend/components/language/locale.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;

    var selectedLocale = Localizations.localeOf(context).toString();

    return Center(
        child: Consumer<LocaleModel>(
            builder: (context, localeModel, child) => DropdownButton(
                  value: selectedLocale,
                  items: const [
                    DropdownMenuItem(
                      value: "fr",
                      child: Text("fr"),
                    ),
                    DropdownMenuItem(
                      value: "en",
                      child: Text("en"),
                    ),
                  ],
                  onChanged: (String? value) {
                    if (value != null) {
                      localeModel.setLocale(Locale(value));
                    }
                  },
                )));
  }
}
