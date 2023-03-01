import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:frontend/models/authentification/login.dart';

class Login {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "http://localhost:3000/user/login";
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(requestModel),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
