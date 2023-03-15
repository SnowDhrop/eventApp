import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/signup_service.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/pages/authentification/login.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:frontend/components/progress_hud.dart';
import 'package:frontend/models/authentification/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pseudoController = TextEditingController();
  final _birthdayController = TextEditingController();

  String _errorMessage = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode focusNode = FocusNode();
  late SignupRequestModel signupRequestModel;

  @override
  void initState() {
    super.initState();
    signupRequestModel =
        SignupRequestModel(email: '', password: '', birthday: '', pseudo: '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _pseudoController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      valueColor: const AlwaysStoppedAnimation<Color>(Constants.whiteText),
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
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
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
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 25),
                            Text(
                              "S'inscrire",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.titilliumWeb(
                                textStyle: const TextStyle(
                                    color: Constants.whiteText,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 38),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              style: const TextStyle(
                                color: Constants.whiteText,
                              ),
                              keyboardType: TextInputType.name,
                              onSaved: (input) =>
                                  signupRequestModel.pseudo = input!.trim(),
                              validator: (input) {
                                if (input!.length < 2 || input.length > 8) {
                                  return "Votre pseudo doit comporter entre 2 et 8 caractères";
                                }
                                if (!RegExp(r'^\w+$').hasMatch(input)) {
                                  return "Votre pseudo ne doit contenir que des lettres et des chiffres sans espaces";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(
                                  color: Constants.whiteText,
                                ),
                                hintText: "Pseudo",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Constants.whiteText,
                                )),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Constants.whiteText,
                                )),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Constants.whiteText,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _emailController,
                              style: const TextStyle(
                                color: Constants.whiteText,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (input) =>
                                  signupRequestModel.email = input!.trim(),
                              validator: (value) {
                                value = value!.trim();
                                if (value.isEmpty) {
                                  return 'Email is required';
                                } else if (!value.contains('@') &&
                                    !value.contains('.fr') &&
                                    !value.contains('.com')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(
                                  color: Constants.whiteText,
                                ),
                                hintText: "Adresse e-mail",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Constants.whiteText,
                                )),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Constants.whiteText,
                                )),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Constants.whiteText,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              style: const TextStyle(
                                color: Constants.whiteText,
                              ),
                              keyboardType: TextInputType.datetime,
                              onSaved: (input) =>
                                  signupRequestModel.birthday = input!.trim(),
                              validator: (input) => input!.trim().isEmpty ||
                                      !input.trim().contains(
                                          RegExp(r'\d{4}-\d{2}-\d{2}'))
                                  ? "La date de naissance doit être valide"
                                  : null,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(
                                  color: Constants.whiteText,
                                ),
                                hintText: "Date de Naissance",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Constants.whiteText,
                                )),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Constants.whiteText,
                                )),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Constants.whiteText,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              style: const TextStyle(
                                color: Constants.whiteText,
                              ),
                              keyboardType: TextInputType.text,
                              onSaved: (input) =>
                                  signupRequestModel.password = input!.trim(),
                              validator: (input) {
                                if (input!.length < 8 || input.length > 16) {
                                  return "Votre mot de passe doit comporter entre 8 et 16 caractères";
                                }
                                if (!RegExp(r'\d').hasMatch(input)) {
                                  return "Votre mot de passe doit contenir un chiffre";
                                }
                                if (!RegExp(r'[a-z]').hasMatch(input)) {
                                  return "Votre mot de passe doit contenir une lettre minuscule";
                                }
                                if (!RegExp(r'[A-Z]').hasMatch(input)) {
                                  return "Votre mot de passe doit contenir une lettre majuscule";
                                }
                                if (!RegExp(r'[-_=!;,?\.:]').hasMatch(input)) {
                                  return "Votre mot de passe doit contenir l'un de ces caractères: -_=!;,?.:";
                                }
                                return null;
                              },
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                  color: Constants.whiteText,
                                ),
                                hintText: "Mot de passe",
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Constants.whiteText,
                                )),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Constants.whiteText,
                                )),
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
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.lightBackground,
                              ),
                              onPressed: () {
                                if (_submitForm()) {
                                  print(signupRequestModel.toJson());
                                  setState(() {
                                    // Add this setState() call to update the loading state in all cases.
                                    isApiCallProcess = false;
                                  });

                                  SignupService signupService = SignupService();
                                  signupService
                                      .signup(signupRequestModel)
                                      .then((response) {
                                    setState(() {
                                      isApiCallProcess = false;
                                    });
                                    print(response);
                                    print(response!.statusCode);
                                    var value = response.data;
                                    print(value['token']);
                                    if (response != null &&
                                        response.statusCode == 200) {
                                      var value = response.data;
                                      print(value['token']);

                                      SignupResponseModel signupResponse =
                                          SignupResponseModel.fromJson(
                                              response.data);

                                      if (signupResponse.token.isNotEmpty) {
                                        storeToken(signupResponse
                                            .token); // Store the token
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Signup successful')),
                                        );
                                      }

                                      Timer(const Duration(seconds: 2), () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder:
                                                        (BuildContext
                                                                context) =>
                                                            const LoginPage()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      });
                                    } else {
                                      // Add this else block to handle unsuccessful responses
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Signup failed. Please try again.')),
                                      );
                                    }
                                  });
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 10, 25, 10),
                                child: Text(
                                  "S'inscrire",
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
                            const SizedBox(height: 15),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants.lightBackground),
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const LoginPage()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(25, 10, 25, 10),
                                  child: Column(children: [
                                    Text(
                                      "Déjà un compte ?",
                                      style: GoogleFonts.titilliumWeb(
                                        textStyle: const TextStyle(
                                            color: Constants.whiteText,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Text(
                                      "Connectez vous ici",
                                      style: GoogleFonts.titilliumWeb(
                                        textStyle: const TextStyle(
                                            color: Constants.whiteText,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ])),
                            ),
                            const SizedBox(height: 15),
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

  bool _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      return true;
    }
    return false;
  }

  void _registerAccount() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final pseudo = _pseudoController.text;
    final birthday = _birthdayController.text;

    setState(() {
      isApiCallProcess = true;
    });

    final signupService = SignupService(); // Create an instance of ApiService
    final response = await signupService.signup(signupRequestModel);

    if (response != null && response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      setState(() {
        isApiCallProcess = false;
        if (response != null) {
          if (response.data['errors'] != null) {
            _errorMessage = '';
            List<dynamic> errors = response.data['errors'];
            for (var error in errors) {
              _errorMessage += '${error['msg']} ';
            }
          } else if (response.data['err'] != null &&
              response.data['err']['name'] ==
                  'SequelizeUniqueConstraintError') {
            _errorMessage = 'Pseudo or email already exists. Please try again.';
          } else {
            _errorMessage = "Error signing up. Please try again later.";
          }
        } else {
          _errorMessage = "Error signing up. Please try again later.";
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage)),
      );
    }
  }
}

Future<void> storeToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}
