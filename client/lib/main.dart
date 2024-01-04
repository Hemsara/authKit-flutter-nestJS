import 'package:client/views/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AuthKit());
}

class AuthKit extends StatelessWidget {
  const AuthKit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "TitilliumWeb",
        useMaterial3: false,
      ),
      home: const OnboardingScreen(),
    );
  }
}
