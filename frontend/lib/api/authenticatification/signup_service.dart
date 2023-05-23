import 'package:dio/dio.dart';
import 'package:frontend/models/authentification/signup.dart';

class SignupService {
  final Dio _dio = Dio();

  Future<Response?> signup(SignupRequestModel signupRequestModel) async {
      final response = await _dio.post(
        'http://localhost:3000/user/signup',
        data: signupRequestModel.toJson(),
      );

      return response;
		}}