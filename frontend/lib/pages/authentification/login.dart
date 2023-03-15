import 'package:flutter/material.dart';
import 'package:frontend/api/login_service.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/home.dart';
import 'package:frontend/pages/authentification/signup.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _errorMessage = '';

  void _submitForm() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      submitLogin(email, password, (errorMessage) {
        setState(() {
          _errorMessage = errorMessage;
        });
      }).then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainHome()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un email.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un mot de passe.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Connexion'),
              ),
              const SizedBox(height: 16.0),
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Constants.lightBackground),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
