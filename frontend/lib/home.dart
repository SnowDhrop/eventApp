import 'package:flutter/material.dart';
import 'package:frontend/components/animations/animated_bar.dart';
import 'package:frontend/components/rive/rive_utils.dart';
import 'package:frontend/constants.dart';
// ignore: implementation_imports
import 'package:flutter/src/painting/gradient.dart' as gradient;
import 'package:frontend/pages/home/home.dart';
import 'package:frontend/pages/map/map.dart';
import 'package:frontend/pages/events/events.dart';
import 'package:frontend/pages/account/account.dart';
import 'package:frontend/pages/profil/profil.dart';
import 'package:rive/rive.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  RiveAsset selectedBottomNav = bottomNavs.first;

  final _pages = [
    const HomePage(),
    const MapPage(),
    const EventsPage(),
    const ProfilPage(),
    const AccountPage()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: _pages[_selectedIndex],
        bottomNavigationBar: SafeArea(
          child: Opacity(
            opacity: 0.85,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, -2), // changes position of shadow
                    ),
                  ],
                  gradient: const gradient.LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.topRight,
                    colors: [
                      Constants.darkBackground,
                      Constants.mediumBackground,
                      Constants.darkBackground
                    ],
                    stops: [
                      0.0,
                      0.5,
                      1.0,
                    ],
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                      bottomNavs.length,
                      (index) => GestureDetector(
                            onTap: () {
                              bottomNavs[index].input!.change(true);
                              if (bottomNavs[index] != selectedBottomNav) {
                                setState(() {
                                  selectedBottomNav = bottomNavs[index];
                                  _selectedIndex = index;
                                });
                              }
                              Future.delayed(const Duration(seconds: 1), (() {
                                bottomNavs[index].input!.change(false);
                              }));
                            },
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AnimatedBar(
                                    isActive:
                                        bottomNavs[index] == selectedBottomNav,
                                  ),
                                  SizedBox(
                                      height: 36,
                                      width: 36,
                                      child: Opacity(
                                          opacity: bottomNavs[index] ==
                                                  selectedBottomNav
                                              ? 1
                                              : 0.7,
                                          child: RiveAnimation.asset(
                                            bottomNavs.first.src,
                                            artboard:
                                                bottomNavs[index].artboard,
                                            onInit: (artboard) {
                                              StateMachineController
                                                  controller =
                                                  RiveUtils.getRiveController(
                                                      artboard,
                                                      stateMachineName:
                                                          bottomNavs[index]
                                                              .stateMachineName);
                                              bottomNavs[index].input =
                                                  controller.findSMI("active")
                                                      as SMIBool;
                                            },
                                          ))),
                                ]),
                          ))
                ],
              ),
            ),
          ),
        ));
  }
}
