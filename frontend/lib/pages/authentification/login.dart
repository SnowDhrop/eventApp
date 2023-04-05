import 'package:flutter/material.dart';

import 'package:frontend/components/progress_hud.dart';

import 'package:frontend/constants/formfield.dart';
import 'package:frontend/constants/space.dart';
import 'package:frontend/constants/text.dart';
import 'package:frontend/main_home.dart';
import 'package:frontend/pages/authentification/signup.dart';

import '../../constants/color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _emailValid = true;
  String _errorMessage = '';
  bool hidePassword = true;
  bool isApiCallProcess = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool _invalidCredentials = false;

  bool _validateCredentials() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    return emailRegex.hasMatch(_emailController.text) &&
        passwordRegex.hasMatch(_passwordController.text);
  }

  void _submitForm() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (_formKey.currentState!.validate() && _validateCredentials()) {
      _invalidCredentials = false;
    } else {
      setState(() {
        _invalidCredentials = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      valueColor:
          const AlwaysStoppedAnimation<Color>(ConstantsColors.primaryColor),
      child: _uiSetup(context),
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Stack(children: [
          const Background(),
          SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const SmallSpace(),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  H1Text(
                                    text: 'Bienvenue',
                                  ),
                                  SmallSpace(),
                                  PText(
                                    text:
                                        'Connectez-vous pour découvrir tous les prochains évènements musicaux et rejoindre tes amis !',
                                  ),
                                ]),
                            const LoginForm(),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(children: [
                                  FittedBox(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Vous n'êtes pas inscrit ?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            child: const Text(
                                              "Inscrivez-vous",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(0xffB000FD)),
                                            ),
                                            onTap: () => Navigator.push(context,
                                                MaterialPageRoute<void>(builder:
                                                    (BuildContext context) {
                                              return const SignupPage();
                                            })),
                                          )
                                        ]),
                                  ),
                                  const ComponentsSpace(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          height: 0.5,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Text(
                                        "Ou",
                                        style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                127, 255, 255, 255)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          height: 0.5,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const ComponentsSpace(),
                                  FittedBox(
                                    child: InkWell(
                                        child: const Text(
                                          "Se connecter en tant qu'invité ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Colors.white,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        onTap: () => Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const MainHome()),
                                                (Route<dynamic> route) =>
                                                    false)),
                                  ),
                                  const ComponentsSpace()
                                ]))
                          ]))))
        ]));
  }
}
