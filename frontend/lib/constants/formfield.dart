import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/api/signup_service.dart';
import 'package:frontend/constants/color.dart';
import 'package:frontend/constants/space.dart';
import 'package:frontend/models/authentification/signup.dart';
import 'package:frontend/pages/authentification/login.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
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
    final emailRegex =
        RegExp(r'/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$/');
    final passwordRegex = RegExp(
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[-_=!;,?.:])[a-zA-Z0-9-_=!;,?.:]{8,16}$');

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
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Container(
          width: 600,
          alignment: Alignment.center,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: CustomFormField(
            hintTextColor: ConstantsColors.greyText,
            iconColor: ConstantsColors.blackBackground,
            hintText: "Email",
            prefixIcon: Icons.email,
            controller: _emailController,
            textStyle: const TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 0, 0, 0)),
            textInputType: TextInputType.emailAddress,
          ),
        ),
        const ComponentsSpace(),
        Container(
          width: 600,
          alignment: Alignment.center,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: CustomFormField(
            hintTextColor: ConstantsColors.greyText,
            iconColor: ConstantsColors.blackBackground,
            hintText: "Mot de passe",
            prefixIcon: Icons.lock,
            controller: _passwordController,
            isPasswordField: true,
            textStyle: const TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        const SmallSpace(),
        InkWell(
          onTap: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage()),
              (Route<dynamic> route) => false),
          child: const Text(
            'Mot de passe oublié ?',
            textAlign: TextAlign.end,
            style: TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: ConstantsColors.secondaryText),
          ),
        ),
        const MediumSpace(),
        Column(children: [
          Container(
            width: 600,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ConstantsColors.primaryColor,
                      ConstantsColors.secondaryColor
                    ])),
            child: ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: const Text(
                'Se connecter',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
          ),
          const ComponentsSpace(),
          if (_invalidCredentials)
            const Text(
              'Mot de passe ou email invalide',
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          const SmallSpace(),
          Text(
            _errorMessage,
            style: const TextStyle(
                color: Colors.red,
                fontFamily: 'Gilroy',
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
        ]),
      ]),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  bool hidePassword = true;

  bool hideConfirmPassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
		_confirmPasswordController.dispose();
    _pseudoController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Container(
          width: 600,
          alignment: Alignment.center,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: CustomFormField(
            hintText: 'Pseudo',
            prefixIcon: Icons.person_2_rounded,
            controller: _pseudoController,
            textStyle: const TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                color: ConstantsColors.greyText),
            hintTextColor: ConstantsColors.greyText,
            iconColor: ConstantsColors.blackText,
          ),
        ),
        const ComponentsSpace(),
        Container(
          width: 600,
          alignment: Alignment.center,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: CustomFormField(
            hintText: 'Date de naissance',
            prefixIcon: Icons.calendar_today_rounded,
            controller: _birthdayController,
            textStyle: const TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                color: ConstantsColors.greyText),
            hintTextColor: ConstantsColors.greyText,
            iconColor: ConstantsColors.blackText,
          ),
        ),
        const ComponentsSpace(),
        Container(
          width: 600,
          alignment: Alignment.center,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: CustomFormField(
            hintText: 'Email',
            prefixIcon: Icons.mail_rounded,
            controller: _emailController,
            textStyle: const TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                color: ConstantsColors.greyText),
            hintTextColor: ConstantsColors.greyText,
            iconColor: ConstantsColors.blackText,
          ),
        ),
        const ComponentsSpace(),
        Container(
          width: 600,
          alignment: Alignment.center,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: CustomFormField(
            hintText: 'Mot de passe',
            prefixIcon: Icons.lock_rounded,
            controller: _passwordController,
            isPasswordField: true,
            textStyle: const TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                color: ConstantsColors.greyText),
            hintTextColor: ConstantsColors.greyText,
            iconColor: ConstantsColors.blackText,
          ),
        ),
        const ComponentsSpace(),
        Container(
          width: 600,
          alignment: Alignment.center,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: CustomFormField(
            hintText: 'Confirmer mot de passe',
            prefixIcon: Icons.lock_rounded,
            controller: _confirmPasswordController,
            isPasswordField: true,
            textStyle: const TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                color: ConstantsColors.greyText),
            hintTextColor: ConstantsColors.greyText,
            iconColor: ConstantsColors.blackText,
          ),
        ),
        const MediumSpace(),
        Column(
          children: [
            Container(
              width: 600,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ConstantsColors.primaryColor,
                        ConstantsColors.secondaryColor
                      ])),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
            	onPressed: () {
								if (_submitForm()) {
									_registerAccount();
								}
							},
            child: const Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: Text(
                'S\'inscrire',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    ),
  ]),
);
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
	print(response);
	 print('Inside _registerAccount()');
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

class CustomFormField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool isPasswordField;
  final TextStyle textStyle;
  final TextInputType textInputType;
  final Color hintTextColor;
  final Color iconColor;

  const CustomFormField({
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.isPasswordField = false,
    required this.textStyle,
    required this.hintTextColor,
    required this.iconColor,
    this.textInputType = TextInputType.text,
    Key? key,
  }) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: widget.textStyle,
      controller: widget.controller,
      obscureText: widget.isPasswordField ? hidePassword : false,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
        hintStyle: widget.textStyle.copyWith(color: widget.hintTextColor),
        hintText: widget.hintText,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        prefixIcon: Icon(
          widget.prefixIcon,
          color: widget.iconColor,
        ),
        suffixIcon: widget.isPasswordField
            ? IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                color: widget.iconColor,
                icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility),
              )
            : null,
      ),
    );
  }
}