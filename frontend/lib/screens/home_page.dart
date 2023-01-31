import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Titre'),
          automaticallyImplyLeading: true
      ),
      body: 
      Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/GetStore');
                }, child: const Text('Test'),
              )
            )
    );
  }
}