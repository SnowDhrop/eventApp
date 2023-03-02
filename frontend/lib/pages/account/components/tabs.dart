import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/pages/account/language/language.dart';

class Tabs extends StatelessWidget {
  final String text;
  final String route;

  const Tabs({
    Key? key,
    required this.text,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        style: style,
        onPressed: () {
          route;
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextSection(
              text: text,
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 24,
              color: Constants.primaryWhite,
            )
          ],
        ),
      ),
    );
  }
}
