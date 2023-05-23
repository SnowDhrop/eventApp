import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:frontend/constants/color.dart';
import 'package:frontend/constants/text.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  EventsPageState createState() => EventsPageState();
}

class EventsPageState extends State<EventsPage> {
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
                    child: PText(
                      text: translation.events,
                    ),
                  ),
                ],
              ))
        ]));
  }
}
