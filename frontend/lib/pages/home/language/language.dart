import 'package:flutter/material.dart';
import 'package:frontend/components/language/locale.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:frontend/constants/color.dart';
import 'package:frontend/constants/text.dart';

class Language extends StatefulWidget {
  final BuildContext context;

  const Language({required this.context, Key? key}) : super(key: key);

  @override
  LanguageState createState() => LanguageState();
}

class LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(widget.context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const Background(),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Consumer<LocaleModel>(
                    builder: (context, localeModel, child) => Builder(
                      builder: (context) => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          //style: style,
                          onPressed: () {
                            Provider.of<LocaleModel>(context, listen: false)
                                .setLocale(const Locale('fr'));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              PText(
                                text: 'Français',
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 24,
                                color: ConstantsColors.primaryText,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: ConstantsColors.primaryText,
                  ),
                  Consumer<LocaleModel>(
                    builder: (context, localeModel, child) => Builder(
                      builder: (context) => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          //style: style,
                          onPressed: () {
                            Provider.of<LocaleModel>(context, listen: false)
                                .setLocale(const Locale('en'));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              PText(
                                text: 'English',
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 24,
                                color: ConstantsColors.primaryText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: ConstantsColors.primaryText,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
