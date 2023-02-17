import 'package:flutter/material.dart';
import 'package:frontend/pages/account/components/tabs.dart';
import 'package:frontend/pages/account/language/language.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:frontend/constants.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  ProfilPageState createState() => ProfilPageState();
}

class ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context)!;
    var buttonWidth = MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                style: style,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Language();
                  }));
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
            const Divider(
              thickness: 2,
              color: Constants.primaryDarkColor,
            ),
          ],
        ));
  }
}
