import 'package:flutter/material.dart';
import 'package:frontend/components/language/locale.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Settings extends StatefulWidget {
  final BuildContext context;

  const Settings({required this.context, Key? key}) : super(key: key);

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
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
                          style: style,
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              TextSection(
                                text: 'Button',
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 24,
                                color: Constants.primaryWhite,
                              ),
                            ],
                          ),
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
          ),
        ],
      ),
    );
  }
}
