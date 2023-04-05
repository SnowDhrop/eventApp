import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/api/signup_service.dart';

import 'package:frontend/constants/color.dart';
import 'package:frontend/constants/formfield.dart';
import 'package:frontend/constants/space.dart';
import 'package:frontend/constants/text.dart';
import 'package:frontend/pages/authentification/login.dart';

import 'package:frontend/components/progress_hud.dart';
import 'package:frontend/models/authentification/signup.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  bool hidePassword = true;

  bool hideConfirmPassword = true;
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
    signupRequestModel = SignupRequestModel(
        email: '', password: '', confirmPassword: '', birthday: '', pseudo: '');
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
      valueColor:
          const AlwaysStoppedAnimation<Color>(ConstantsColors.primaryText),
      child: _uiSetup(context),
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          const Background(),
          SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const BigSpace(),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                alignment: Alignment.bottomLeft,
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 40,
                                  color: ConstantsColors.primaryText,
                                ),
                              ),
                              const MediumSpace(),
                              const H1Text(
                                text: 'Inscrivez-vous',
                              ),
                              const SmallSpace(),
                              const PText(
                                text:
                                    'Créez un compte pour accéder à plus de fonctionnalités !',
                              ),
                            ]),
                        const MediumSpace(),
                        const SignUpForm()
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
