import 'package:client/res/dimens.dart';
import 'package:client/shared/button.dart';
import 'package:client/shared/logo.dart';
import 'package:client/shared/textfield.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuthKitLogo(),
              const TextInputField(
                icon: Iconsax.user,
                hintText: "E-mail address",
              ),
              const TextInputField(
                icon: Iconsax.key,
                hintText: "Password",
              ),
              AppDimens.gap(1),
              const PrimaryButton(
                text: "Login",
                outlined: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
