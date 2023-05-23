import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/api/authenticatification/user_service.dart';
import 'package:frontend/components/language/locale.dart';
import 'package:frontend/main_home.dart';
import 'package:frontend/pages/authentification/login.dart';
import 'package:provider/provider.dart';
import 'package:frontend/constants/color.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart' as jwt_decoder;

Future<void> main() async {
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

Future<void> navigationPage(BuildContext context) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  if (token != null) {
    final Map<String, dynamic> decodedToken = jwt_decoder.JwtDecoder.decode(token);
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
    if (DateTime.now().isBefore(expiryDate)) {
      final userId = decodedToken['userId'].toString();
      try {
        final String pseudo = await getUserPseudo(userId);
				String profilePicBase64 = await getUserPic(userId);

        Navigator.push(
          context,
          MaterialPageRoute(
						builder: (context) => 
						MainHome(
							pseudo: pseudo, profilePicBase64: profilePicBase64)),
        );
      } catch (e) {
        // Handle the error, such as displaying an error message or navigating to a different page
      }
      return;
    }
  }
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
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
        width: MediaQuery.of(context).size.width * 0.4,
      ))
    ]));
  }
}
