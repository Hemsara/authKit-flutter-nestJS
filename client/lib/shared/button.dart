import 'package:client/res/dimens.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final IconData? iconData;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onTap,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                  color: const Color.fromARGB(255, 67, 67, 67),
                  size: 20.0,
                ),
              AppDimens.gap(iconData != null ? 1 : 0), // Adjust spacing
              Text(
                text.toUpperCase(),
                style: const TextStyle(
                  letterSpacing: 1.2,
                  color: Color.fromARGB(255, 67, 67, 67),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
