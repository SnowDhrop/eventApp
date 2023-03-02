import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class Constants {
  // Primary color palette
  static const Color primaryColor = Color(0xff008DC9); // WHO BLUE
  static const Color primaryDarkColor = Color(0xff2364AA); // NEW BLUE
  static const Color accentColor = Color(0xffD86422); // ORANGE
  static const Color whoAccentYellowColor = Color(0xffFFCC00); // YELLOW
  static const Color accentTealColor = Color(0xff44BBA4); // TEAL
  static const Color transparent = Color.fromARGB(0, 0, 0, 0); // Transparent
  static const Color primaryWhite = Color.fromARGB(255, 230, 224, 224); // White
  static const Color whiteText = Color(0xffFFFDF7); // White Text

  // Background colors
  static const Color darkBackground = Color(0xff100c13); // Dark Purple
  static const Color lightBackground = Color(0xff8656ba); // Light Purple
  static const Color mediumBackground = Color(0xff0d0216); // Medium Purple

  // Element colors
  static const Color bodyTextColor = Color(0xff272626); // CHARCOAL
  static const Color textColor = Color(0xff3C4245); // GREY
  static const Color emergencyRedColor = Color(0xffD82037);
  static const Color menuButtonColor = Color(0xCC1694BE);
  static const Color successCheckColor = Color(0xff9BC53D); // NEW GREEN
  static const Color itemBorderColor = Color.fromARGB(64, 92, 97, 100);

  // Neutral Colors
  static const Color neutral1Color = Color(0xff050C1D);
  static const Color neutral2Color = Color(0xff26354E);
  static const Color neutral3Color = Color(0xffC9CDD6); // LIGHT GREY
  static const Color neutralTextColor = Color(0xff3C4245);
  static const Color neutralTextLightColor = Color(0xff5C6164);
  static const Color neutralTextDarkColor = Color(0xff1C1E1F);

  // Illustration Colors
  static const Color illustrationBlue1Color = Color(0xffD5F5FD);
  static const Color illustrationPinkColor = Color(0xffEC96AA); // PINK

  // Spacing
  static const double buttonTextSpacing = -.4;
}

final ButtonStyle style = TextButton.styleFrom(
  textStyle: GoogleFonts.titilliumWeb(
      color: Constants.primaryWhite,
      fontSize: 24 - 5,
      fontWeight: FontWeight.w500),
);

// Return a scaling factor between 0.0 and 1.0 for screens heights ranging
// from a fixed short to tall range.
double contentScale(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  const tall = 896.0;
  const short = 480.0;
  return ((height - short) / (tall - short)).clamp(0.0, 1.0);
}

// Return a value between low and high for screens heights ranging
// from a fixed short to tall range.
double contentScaleFrom(BuildContext context, double low, double high) {
  return low + contentScale(context) * (high - low);
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
                Constants.darkBackground,
                Constants.lightBackground,
                Constants.darkBackground
              ],
              stops: [
                0.0,
                0.5,
                1.0,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            image: DecorationImage(
                image: const AssetImage(
                  'assets/background/noise_background.jpg',
                ),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.05), BlendMode.dstATop),
                repeat: ImageRepeat.repeat)));
  }
}

class TextSection extends StatefulWidget {
  final String text;

  const TextSection({required this.text, Key? key}) : super(key: key);

  @override
  TextSectionState createState() => TextSectionState();
}

class TextSectionState extends State<TextSection> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.titilliumWeb(
          color: Constants.primaryWhite,
          fontSize: 24 - 5,
          fontWeight: FontWeight.w500),
    );
  }
}
