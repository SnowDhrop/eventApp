import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:draggable_home/draggable_home.dart';

import 'package:frontend/components/animations/animated_bar.dart';
import 'package:frontend/constants/color.dart';
import 'package:frontend/constants/shadow.dart';

class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TopAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(150);

  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  Widget _buildSvgIcon(String assetPath, {Color color = Colors.white}) {
    return SvgPicture.asset(
      assetPath,
      height: 30,
      width: 30,
    );
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context)!;

    return Stack(alignment: AlignmentDirectional.topCenter, children: [
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 20, 20, 20),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70),
            bottomRight: Radius.circular(70),
          ),
        ),
        height: 100,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(60, 10, 60, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconShadow(
                child: SvgPicture.asset(
                  'assets/icons/messages.svg',
                ),
              ),
              const Padding(
                  padding: EdgeInsetsDirectional.only(top: 20),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 38,
                    color: ConstantsColors.primaryText,
                  )),
              IconShadow(
                  child: SvgPicture.asset(
                'assets/icons/friends.svg',
              )),
            ],
          ),
        ),
      )
    ]);
  }
}

class OvalTopBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 10,
      size.height,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - size.width / 10,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
