import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  // Primary color palette
  static const Color primaryColor = Color(0xff008DC9); // WHO BLUE
  static const Color primaryDarkColor = Color(0xff2364AA); // NEW BLUE
  static const Color accentColor = Color(0xffD86422); // ORANGE
  static const Color whoAccentYellowColor = Color(0xffFFCC00); // YELLOW
  static const Color accentTealColor = Color(0xff44BBA4); // TEAL
  static const Color transparent = Color.fromARGB(0, 0, 0, 0); // Transparent
  static const Color primaryWhite = Color.fromARGB(255, 230, 224, 224); // White
  static const Color secondaryWhite =
      Color.fromARGB(185, 209, 209, 209); // Light White

  // Background colors
  static const Color primaryBackground =
      Color.fromARGB(255, 8, 31, 68); // WHITE
  static const Color secondaryBackground =
      Color.fromARGB(255, 39, 57, 110); // GREY
  static const Color secondaryAppbarBackground =
      Color.fromARGB(255, 49, 51, 51);
  static const Color blackBackground = Color(0xff171A1D); // WHO BLUE 2
  static const Color appbarBackground = Color.fromARGB(255, 31, 32, 32);
  static const Color homeHeaderGreenColor = Color(0xffFAE8A9);

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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Constants.primaryBackground,
            Constants.secondaryBackground,
            Constants.blackBackground
          ],
        ),
      ),
    );
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
