import 'package:flutter/material.dart';

class SmallSpace extends StatefulWidget {
  const SmallSpace({Key? key}) : super(key: key);

  @override
  SmallSpaceState createState() => SmallSpaceState();
}

class SmallSpaceState extends State<SmallSpace> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
    );
  }
}

class ComponentsSpace extends StatefulWidget {
  const ComponentsSpace({Key? key}) : super(key: key);

  @override
  ComponentsSpaceState createState() => ComponentsSpaceState();
}

class ComponentsSpaceState extends State<ComponentsSpace> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 22,
    );
  }
}

class MediumSpace extends StatefulWidget {
  const MediumSpace({Key? key}) : super(key: key);

  @override
  MediumSpaceState createState() => MediumSpaceState();
}

class MediumSpaceState extends State<MediumSpace> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
    );
  }
}

class BigSpace extends StatefulWidget {
  const BigSpace({Key? key}) : super(key: key);

  @override
  BigSpaceState createState() => BigSpaceState();
}

class BigSpaceState extends State<BigSpace> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
    );
  }
}
