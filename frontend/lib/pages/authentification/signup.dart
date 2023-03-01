import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/pages/home/home.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:frontend/api/authentification/signup_service.dart';
import 'package:frontend/pages/authentification/login.dart';
import 'package:frontend/components/progress_hud.dart';

import 'package:frontend/models/authentification/login.dart';
import 'package:frontend/models/authentification/signup.dart';
import 'package:frontend/home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late LoginRequestModel loginRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode focusNode = FocusNode();
  late SignupRequestModel signupRequestModel;
  @override
  void initState() {
    super.initState();
    signupRequestModel =
        SignupRequestModel(email: '', password: '', phone: '', pseudo: '');
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
                        key: globalFormKey,
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
                                  signupRequestModel.pseudo = input!,
                              validator: (input) =>
                                  !input!.contains(RegExp(r'[a-z]'))
                                      ? "Le nom doit être valide"
                                      : null,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(
                                  color: Constants.whiteText,
                                ),
                                hintText: "Nom",
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
                            TextFormField(
                              style: const TextStyle(
                                color: Constants.whiteText,
                              ),
                              keyboardType: TextInputType.phone,
                              onSaved: (input) =>
                                  signupRequestModel.phone = input!,
                              validator: (input) => !input!.contains(RegExp(
                                      r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$'))
                                  ? "Le numéro de téléphone doit être valide"
                                  : null,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(
                                  color: Constants.whiteText,
                                ),
                                hintText: "Mobile",
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
                            const SizedBox(
                              height: 20,
                            ),
                            // DropdownButtonFormField<String>(
                            //   onSaved: (input) => signupRequestModel.type = input!,

                            //   focusNode: focusNode,
                            //   borderRadius: BorderRadius.circular(15),
                            //   focusColor: const Color(0xffDF9984),
                            //   style: GoogleFonts.poppins(textStyle:const TextStyle(fontSize: 16,color:Color(0xffDF9984),),),
                            //   dropdownColor: const Color(0xffEBDEC7),
                            //   iconEnabledColor: const Color(0xffDF9984),
                            //   iconDisabledColor: const Color(0xffDF9984),
                            //   decoration: const InputDecoration(
                            //     enabledBorder: UnderlineInputBorder(
                            //         borderSide: BorderSide(
                            //             color: Color(0xffDF9984)
                            //                 )),
                            //     focusedBorder: UnderlineInputBorder(
                            //         borderSide: BorderSide(
                            //             color: Color(0xffDF9984)
                            //                 )),
                            //     border: UnderlineInputBorder(
                            //         borderSide: BorderSide(
                            //             color: Color(0xffDF9984)
                            //                 )),
                            //     iconColor: Color(0xffDF9984),
                            //     prefixIconColor: Color(0xffDF9984),
                            //     hintStyle: TextStyle(color: Color(0xffDF9984)),
                            //     prefixIcon: Icon(Icons.person,color: Color(0xffDF9984),),
                            //     fillColor: Color(0xffDF9984),
                            //   ),

                            //   hint: const Text('Choisissez le type de compte',
                            //   style: TextStyle(color: Color(0xffDF9984)),),
                            //   items: <String>['user', 'promoter', 'admin'].map((String value) {
                            //   return DropdownMenuItem<String>(
                            //     value: value,
                            //     child: Text(value, style: const TextStyle(color: Color(0xffDF9984)),),
                            //   );
                            //   }).toList(),
                            //   onChanged: (_) {},
                            // ),
                            TextFormField(
                              style: const TextStyle(
                                color: Constants.whiteText,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (input) =>
                                  signupRequestModel.email = input!,
                              validator: (input) => !input!.contains('@')
                                  ? "L'adresse e-mail doit être valide"
                                  : null,
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
                              keyboardType: TextInputType.text,
                              onSaved: (input) =>
                                  signupRequestModel.password = input!,
                              validator: (input) => input!.length < 3
                                  ? "Le mot de passe doit être à plus de trois caractères"
                                  : null,
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
                                  backgroundColor: Constants.lightBackground),
                              onPressed: () {
                                if (validateAndSave()) {
                                  print(signupRequestModel.toJson());

                                  setState(() {
                                    isApiCallProcess = true;
                                  });

                                  Signup apiService = Signup();
                                  apiService
                                      .signup(signupRequestModel)
                                      .then((value) {
                                    if (value != null) {
                                      setState(() {
                                        isApiCallProcess = false;
                                      });

                                      if (value.token.isNotEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text(value.error)),
                                        );
                                        Timer(const Duration(seconds: 2), () {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (BuildContext
                                                                  context) =>
                                                              const HomePage()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text(value.error)),
                                        );
                                      }
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

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
