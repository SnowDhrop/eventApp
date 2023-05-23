import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> submitLogin(
    String email, String password, Function(String) errorCallback) async {
  try {
    final response = await Dio().get(
      'http://localhost:3000/user/login',
    );
    if (response.statusCode == 200) {
      final responseData = response.data;
      final token = responseData['token'];

      final prefs = await SharedPreferences.getInstance();

      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: token);

      await prefs.setString('token', token);
    } else {
      errorCallback('Email ou mot de passe invalide.');
    }
  } catch (error) {
    errorCallback('Une erreur est survenue, veuillez réessayer.');
    print(error);
  }
}
