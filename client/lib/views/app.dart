import 'package:client/res/dimens.dart';
import 'package:client/res/navigator.dart';
import 'package:client/shared/button.dart';
import 'package:client/shared/logo.dart';
import 'package:client/views/login/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Header(), // Adjust spacing
              PrimaryButton(
                onTap: () {
                  NavigatorHelper.to(const LoginScreen());
                },
                text: "Login now",
                iconData: Iconsax.user,
              ),
              const PrimaryButton(
                text: "Create an account",
                iconData: Iconsax.user,
              ),
              AppDimens.gap(2),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthKitLogo(), // Adjust spacing

        Text(
          "Robust authentication integration for your Flutter mobile app with NestJS on the server side.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        AppDimens.gap(7),
      ],
    );
  }
}
