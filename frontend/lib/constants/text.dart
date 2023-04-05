import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend/constants/color.dart';

class H1Text extends StatefulWidget {
  final String text;

  const H1Text({required this.text, Key? key}) : super(key: key);

  @override
  H1TextState createState() => H1TextState();
}

class H1TextState extends State<H1Text> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 42,
        fontWeight: FontWeight.w600,
        color: ConstantsColors.primaryText,
      ),
    );
  }
}

class H2Text extends StatefulWidget {
  final String text;

  const H2Text({required this.text, Key? key}) : super(key: key);

  @override
  H2TextState createState() => H2TextState();
}

class H2TextState extends State<H2Text> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 22,
        fontWeight: FontWeight.w900,
        color: ConstantsColors.primaryText,
      ),
    );
  }
}

class PText extends StatefulWidget {
  final String text;

  const PText({required this.text, Key? key}) : super(key: key);

  @override
  PTextState createState() => PTextState();
}

class PTextState extends State<PText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: ConstantsColors.primaryText,
      ),
    );
  }
}

class InputText extends StatefulWidget {
  final String text;

  const InputText({required this.text, Key? key}) : super(key: key);

  @override
  InputTextState createState() => InputTextState();
}

class InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: ConstantsColors.blackText,
      ),
    );
  }
}
