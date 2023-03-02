import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:frontend/models/authentification/user.dart';

class GetUser extends StatefulWidget {
  final User? user;
  const GetUser({super.key, this.user});

  @override
  GetUserState createState() => GetUserState();
}

class GetUserState extends State<GetUser> {
  List<User> user = [];
  Future<List<User>> getAll() async {
    var response = await http.get(Uri.parse("http://localhost:8092/api/users"));

    if (response.statusCode == 200) {
      user.clear();
    }
    var decodedData = jsonDecode(response.body);

    for (var u in decodedData) {
      user.add(User(u['email'], u['pseudo'], u['phone']));
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    getAll();

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Color(0xffFFFFFF), boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1),
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Bonjour'),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
