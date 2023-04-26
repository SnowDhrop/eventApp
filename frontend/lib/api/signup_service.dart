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
    } on DioError catch (e) {
  print('API call failed: ${e.message}');
  print('API call failed with error type: ${e.type}');
  if (e.response != null) {
    print('API call failed: ${e.response!.data}');
    print('API call failed with status code: ${e.response!.statusCode}');
    print('API call failed with headers: ${e.response!.headers}');
  } else {
    print('API call failed: ${e.requestOptions.path}');
  }
  return Future.error(e);
		}}}