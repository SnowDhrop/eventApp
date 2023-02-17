import 'package:flutter/material.dart';
import 'package:frontend/components/language/locale.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  LanguageState createState() => LanguageState();
}

class LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Constants.primaryBackground,
                Constants.secondaryBackground,
                Constants.blackBackground
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          const Background(),
          Center(
            child: Column(
              children: [
                Consumer<LocaleModel>(
                  builder: (context, localeModel, child) => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      style: style,
                      onPressed: () async =>
                          {localeModel.set(const Locale('fr'))},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Consumer<LocaleModel>(
                            builder: (context, localeModel, child) =>
                                TextSection(
                              text: AppLocalizations.of(context)!.languagefr,
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            size: 24,
                            color: Constants.primaryWhite,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Constants.primaryDarkColor,
                ),
                Consumer<LocaleModel>(
                  builder: (context, localeModel, child) => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      style: style,
                      onPressed: () async =>
                          {localeModel.set(const Locale('en'))},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Consumer<LocaleModel>(
                            builder: (context, localeModel, child) =>
                                TextSection(
                              text: AppLocalizations.of(context)!.languageen,
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            size: 24,
                            color: Constants.primaryWhite,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Constants.primaryDarkColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
