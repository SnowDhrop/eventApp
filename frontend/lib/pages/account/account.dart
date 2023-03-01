import 'package:flutter/material.dart';
import 'package:frontend/pages/account/components/tabs.dart';
import 'package:frontend/pages/account/language/language.dart';
import 'package:frontend/pages/account/settings/settings.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:frontend/constants.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context)!;
    var buttonWidth = MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Stack(children: [
          const Background(),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  Center(
                    child: TextSection(
                      text: translation.account,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      style: style,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Language(context: context);
                          }),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextSection(
                            text: translation.language,
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            size: 24,
                            color: Constants.primaryWhite,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Constants.primaryDarkColor,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      style: style,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Settings(context: context);
                          }),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextSection(
                            text: translation.settings,
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            size: 24,
                            color: Constants.primaryWhite,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Constants.primaryDarkColor,
                  ),
                ],
              ))
        ]));
  }
}
