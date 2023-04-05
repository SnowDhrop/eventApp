import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConstantsColors {
  // Primary color palette
  static const Color primaryColor = Color(0xffB000FD); // Light Purple
  static const Color secondaryColor = Color(0xff5A16A6); // Dark Purple

  // Text color
  static const Color primaryText = Color(0xffFFFFFF); // White
  static const Color secondaryText =
      Color.fromARGB(127, 255, 255, 255); // 50% Opacity White
  static const Color blackText = Color(0xff000000); // Black
  static const Color greyText = Color.fromARGB(167, 0, 0, 0); // Grey
  static const Color blackBackground = Color(0xff000000); // Black
  static const Color purpleBackground =
      Color.fromARGB(255, 34, 10, 63); // Medium Purple
  static const Color appBarBackground = Color(0xff111214); // Light Dark
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                ConstantsColors.blackBackground,
                ConstantsColors.purpleBackground
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            image: DecorationImage(
                image: const AssetImage(
                  'assets/background/noise_background.jpg',
                ),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.03), BlendMode.dstATop),
                repeat: ImageRepeat.repeat)));
  }
}
