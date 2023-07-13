import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/components/navigation/bottom_app_bar.dart';
import 'package:frontend/components/navigation/top_app_bar.dart';
import 'package:frontend/constants/color.dart';
import 'package:frontend/pages/home/home.dart';
import 'package:frontend/pages/map/map.dart';
import 'package:frontend/pages/events/events.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainHome extends StatefulWidget {
  final String pseudo;
	final String profilePicBase64;
  const MainHome({Key? key, required this.pseudo, required this.profilePicBase64}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  late List<Widget> _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(pseudo: widget.pseudo, profilePicBase64: widget.profilePicBase64,),
      const MapPage(),
      const EventsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        extendBody: true,
        appBar: const TopAppBar(),
        body: _pages[_selectedIndex],
        bottomNavigationBar: MainBottomAppBar(
          selectedIndex: _selectedIndex,
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ));
  }
}
