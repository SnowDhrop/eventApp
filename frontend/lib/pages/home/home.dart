import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/api/event/event.dart';
import 'package:frontend/constants/space.dart';
import 'package:frontend/models/authentification/signup.dart';
import 'package:frontend/pages/home/language/language.dart';
import 'package:frontend/pages/home/settings/settings.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:frontend/constants/color.dart';
import 'package:frontend/constants/text.dart';
import 'dart:ui' as ui;

import '../../models/events/event.dart';


class HomePage extends StatefulWidget {
	final String pseudo;
	final String profilePicBase64;
  const HomePage({Key? key, required this.pseudo, required this.profilePicBase64}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
	
	late ImageProvider _profilePicImageProvider;
	  List<Event> _events = [];
  	bool _isLoading = true;

		  Future<void> _fetchEvents() async {
    try {
      GetAllEvent getAllEvent = GetAllEvent();
      List<Event> events = await getAllEvent.fetchEvents();
      setState(() {
        _events = events;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error, e.g., show a snackbar with an error message
    }
  }

  @override
  void initState() {
    super.initState();
    _profilePicImageProvider =
        MemoryImage(base64Decode(widget.profilePicBase64));
		_fetchEvents();

  }
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
                        Row(
													children: [
														H2Text(
														text: 'Bonsoir ${widget.pseudo}!',
													),
													Padding(
      											padding: const EdgeInsets.only(left: 16),
														child:
														ClipOval(
															child: SizedBox(
																width: 60,
																height: 60,
																child: FutureBuilder<ui.Image>(
																	future: _getImage(context, _profilePicImageProvider),
																	builder: (context, snapshot) {
																		if (snapshot.connectionState == ConnectionState.done) {
																			return Image(
																				image: _profilePicImageProvider,
																				width: 60,
																				height: 60,
																				fit: BoxFit.cover,
																			);
																		} else {
																			return const CircularProgressIndicator();
																		}
																	},
															
																),
															),
														),
													)
												]),
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
                    const H2Text(text: 'Nos coup de coeurs !'),
										const PText(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam nec erat non elit auctor blandit. Morbi pellentesque elit vel dui tincidunt, vitae pharetra ante maximus.'),
										_isLoading
												? const CircularProgressIndicator()
												: Expanded(
														child: ListView.builder(
															itemCount: _events.length,
															itemBuilder: (BuildContext context, int index) {
																final event = _events[index];
																return ListTile(
																	title: Text(event.title),
																	subtitle: Text(event.description),
																	// Add more event details as needed
																);
															},
														),
													),
										const ComponentsSpace(),
                    const H2Text(text: 'Evènements à proximité'),
										const PText(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam nec erat non elit auctor blandit. Morbi pellentesque elit vel dui tincidunt, vitae pharetra ante maximus.'),
										const ComponentsSpace(),
                    const H2Text(text: 'Evènements'),
										const PText(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam nec erat non elit auctor blandit. Morbi pellentesque elit vel dui tincidunt, vitae pharetra ante maximus.'),
									]))
        ]));
  }


 Future<ui.Image> _getImage(
      BuildContext context, ImageProvider imageProvider) async {
    Completer<ui.Image> completer = Completer();
    imageProvider.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo info, bool _) => completer.complete(info.image)));
    return completer.future;
  }
}