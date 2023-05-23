import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart' as jwt_decoder;
import 'dart:convert';

Future<String> getUserPseudo(String userId) async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
	print(token);
  final Map<String, dynamic> decodedToken = jwt_decoder.JwtDecoder.decode(token!);
  final userId = decodedToken['userId'].toString();

  // Make an API call to fetch the user's pseudo based on their id
  // Replace the URL, headers, and other parameters as needed
  final response = await Dio().get('http://localhost:3000/user/search/$userId',
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ),
  );

  if (response.statusCode == 200) {
    // If the API call is successful, return the user's pseudo
    return response.data['users']['pseudo'];
  } else {
    // If the API call fails, throw an error
    throw Exception('Failed to fetch user pseudo');
  }
}

Future<String> getUserPic(String userId) async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');
	print(token);
  final Map<String, dynamic> decodedToken = jwt_decoder.JwtDecoder.decode(token!);
  final userId = decodedToken['userId'].toString();
	
  // Make an API call to fetch the user's pseudo based on their id
  // Replace the URL, headers, and other parameters as needed
  final response = await Dio().get('http://localhost:3000/user/search/$userId',
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ),
  );

  if (response.statusCode == 200) {
    // If the API call is successful, return the user's pseudo
    return response.data['users']['profilePic'];
  } else {
    // If the API call fails, throw an error
    throw Exception('Failed to fetch user pseudo');
  }
}