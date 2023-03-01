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
  String email;
  String password;
  String pseudo;
  String phone;

  SignupRequestModel({
    required this.email,
    required this.password,
    required this.pseudo,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
      'pseudo': pseudo.trim(),
      'phone': phone.trim(),
    };

    return map;
  }
}
