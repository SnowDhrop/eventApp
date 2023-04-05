class SignupResponseModel {
  final String token;
  final String error;

  SignupResponseModel({required this.token, required this.error});

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      token: json["token"] ?? "",
      error: json["error"] ?? "",
    );
  }
}

class SignupRequestModel {
  String pseudo;
  String email;
  String password;
  String confirmPassword;
  String birthday;

  SignupRequestModel({
    required this.pseudo,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.birthday,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'pseudo': pseudo.trim(),
      'email': email.trim(),
      'password': password.trim(),
      'confirmPassword': confirmPassword.trim(),
      'birthday': birthday.trim(),
    };

    return map;
  }
}
