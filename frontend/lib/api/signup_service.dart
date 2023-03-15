import 'package:dio/dio.dart';
import 'package:frontend/models/authentification/signup.dart';

class SignupService {
  final Dio _dio = Dio();

  Future<Response?> signup(SignupRequestModel signupRequestModel) async {
    try {
      final response = await _dio.post(
        'http://localhost:3000/user/signup',
        data: signupRequestModel.toJson(),
      );
      print('Response data: ${response.data}');
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
