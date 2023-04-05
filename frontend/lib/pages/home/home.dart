import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/constants/space.dart';
import 'package:frontend/pages/home/language/language.dart';
import 'package:frontend/pages/home/settings/settings.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:frontend/constants/color.dart';
import 'package:frontend/constants/text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
              padding: const EdgeInsets.fromLTRB(10, 120, 10, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const H2Text(
                          text: 'Bonsoir :user !',
                        ),
                        Row(children: [
                          IconButton(
                            // style: style,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return Settings(context: context);
                                }),
                              );
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/profil.svg',
                            ),
                          ),
                          IconButton(
                            // style: style,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return Language(context: context);
                                }),
                              );
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/notifications.svg',
                            ),
                          ),
                          IconButton(
                            // style: style,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return Language(context: context);
                                }),
                              );
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/settings.svg',
                            ),
                          ),
                        ])
                      ],
                    ),
                    const ComponentsSpace(),
                    const H2Text(text: 'Nos coup de coeurs !')
                  ]))
        ]));
  }
}
