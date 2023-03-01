import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:frontend/models/authentification/signup.dart';

class Signup {
  Future<SignupResponseModel> signup(SignupRequestModel requestModel) async {
    String url = "http://localhost:3000/user/signup";
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(requestModel),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201 || response.statusCode == 400) {
      return SignupResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
