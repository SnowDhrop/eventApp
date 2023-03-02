class User {
  String email;
  String pseudo;
  String phone;

  User(this.email, this.pseudo, this.phone);

  User.fromJson(Map json)
      : email = json['email'],
        pseudo = json['pseudo'],
        phone = json['phone'];

  Map toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
