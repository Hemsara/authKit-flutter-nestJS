import 'package:client/res/colors.dart';
import 'package:client/res/dimens.dart';
import 'package:client/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
              SvgPicture.asset(
                'assets/images/nest.svg',
                height: 90,
              ),
              AppDimens.gap(1), // Adjust spacing
              Text(
                "Nest AuthKit",
                style: TextStyle(
                    fontSize: 30,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600),
              ),
              AppDimens.gap(2), // Adjust spacing

              Text(
                "Robust authentication integration for your Flutter mobile app with NestJS on the server side.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              AppDimens.gap(7), // Adjust spacing
              const PrimaryButton(
                text: "Login now",
                iconData: Iconsax.user,
              ),
              const PrimaryButton(
                text: "Create an account",
                iconData: Iconsax.user,
              )
            ],
          ),
        ),
      ),
    );
  }
}
