import 'package:flutter/material.dart';
import 'package:frontend/constants/color.dart';

class IconShadow extends StatefulWidget {
  final Widget child;

  const IconShadow({required this.child, Key? key}) : super(key: key);

  @override
  IconShadowState createState() => IconShadowState();
}

class IconShadowState extends State<IconShadow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: ConstantsColors.primaryColor,
                spreadRadius: 1,
                blurRadius: 30,
                blurStyle: BlurStyle.normal)
          ]),
      child: Material(
        // Add this Material widget
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.transparent,
        child: widget.child,
      ),
    );
  }
}
