import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/components/language/locale.dart';
import 'package:frontend/home.dart';
import 'package:frontend/pages/authentification/login.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleModel(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleModel(),
      child: Consumer<LocaleModel>(
        builder: (context, localeModel, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          title: 'Maestrip',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeModel.locale,
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  startTime(BuildContext context) async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () => navigationPage(context));
  }

  void navigationPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    startTime(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const Background(),
      Center(
          child: Image.asset(
        'assets/logo/logo_blanc.png',
        width: MediaQuery.of(context).size.width * 0.9,
      ))
    ]));
  }
}
