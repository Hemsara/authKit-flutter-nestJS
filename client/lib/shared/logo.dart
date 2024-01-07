import 'package:client/res/colors.dart';
import 'package:client/res/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthKitLogo extends StatelessWidget {
  const AuthKitLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        AppDimens.gap(2),
      ],
    );
  }
}
