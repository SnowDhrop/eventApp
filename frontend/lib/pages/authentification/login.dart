import 'dart:async';
import 'package:flutter/material.dart';

import 'package:frontend/constants.dart';
import 'package:frontend/home.dart';
import 'package:frontend/pages/authentification/signup.dart';
import 'package:frontend/pages/home/home.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:frontend/components/progress_hud.dart';
import 'package:frontend/models/authentification/login.dart';
import 'package:frontend/api/authentification/login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late LoginRequestModel loginRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    loginRequestModel = LoginRequestModel(email: '', password: '');
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      child: _uiSetup(context),
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Stack(children: [
          const Background(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 25,
                ),
                Center(
                    child: Text(
                  'Bienvenue sur MAESTRIP',
                  style: GoogleFonts.titilliumWeb(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      color: Constants.whiteText,
                    ),
                  ),
                  textAlign: TextAlign.center,
                )),
                Stack(
                  children: <Widget>[
                    Container(
                      width: 700,
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      margin: const EdgeInsets.symmetric(
                          vertical: 35, horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Constants.lightBackground,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(36, 134, 86, 186),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 4),
                              blurRadius: 6)
                        ],
                      ),
                      child: Form(
                        key: globalFormKey,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 25),
                            Text(
                              "Se connecter",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.titilliumWeb(
                                textStyle: const TextStyle(
                                    color: Constants.whiteText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 48),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              style:
                                  const TextStyle(color: Constants.whiteText),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (input) =>
                                  loginRequestModel.email = input!,
                              validator: (input) => !input!.contains('@')
                                  ? "Email Id should be valid"
                                  : null,
                              decoration: const InputDecoration(
                                hintStyle:
                                    TextStyle(color: Constants.whiteText),
                                hintText: "Adresse e-mail",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Constants.whiteText)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Constants.whiteText)),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Constants.whiteText,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              style:
                                  const TextStyle(color: Constants.whiteText),
                              keyboardType: TextInputType.text,
                              onSaved: (input) =>
                                  loginRequestModel.password = input!,
                              validator: (input) => input!.length < 3
                                  ? "Password should be more than 3 characters"
                                  : null,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                hintStyle:
                                    const TextStyle(color: Constants.whiteText),
                                hintText: "Mot de passe",
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Constants.whiteText)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Constants.whiteText)),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Constants.whiteText,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  color: Constants.whiteText,
                                  icon: Icon(hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Constants.lightBackground),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                                ),
                                onPressed: () {
                                  // if (validateAndSave()) {
                                  //   print(loginRequestModel.toJson());

                                  //   setState(() {
                                  //     isApiCallProcess = true;
                                  //   });

                                  //   Login apiService = Login();
                                  //   apiService
                                  //       .login(loginRequestModel)
                                  //       .then((value) {
                                  //     if (value != null) {
                                  //       setState(() {
                                  //         isApiCallProcess = false;
                                  //       });

                                  //       if (value.token.isNotEmpty) {
                                  //         ScaffoldMessenger.of(context)
                                  //             .showSnackBar(
                                  //           const SnackBar(
                                  //               content:
                                  //                   Text('Connexion Réussie!')),
                                  //         );
                                  Timer(const Duration(seconds: 2), () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const MainHome()),
                                        (Route<dynamic> route) => false);
                                  });
                                  //       } else {
                                  //         ScaffoldMessenger.of(context)
                                  //             .showSnackBar(
                                  //           SnackBar(
                                  //               content: Text(value.error)),
                                  //         );
                                  //       }
                                  //     }
                                  //   });
                                  // }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(25, 10, 25, 10),
                                  child: Text(
                                    "Se connecter",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.titilliumWeb(
                                      textStyle: const TextStyle(
                                          color: Constants.whiteText,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Constants.lightBackground),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const SignupPage()),
                                      (Route<dynamic> route) => false);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        25, 10, 25, 10),
                                    child: Column(children: [
                                      Text(
                                        "Pas encore de compte?",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.titilliumWeb(
                                          textStyle: const TextStyle(
                                              color: Constants.whiteText,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Text(
                                        "Inscrivez vous ici",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.titilliumWeb(
                                          textStyle: const TextStyle(
                                              color: Constants.whiteText,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ])),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]));
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
