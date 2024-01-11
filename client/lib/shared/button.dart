import 'package:client/res/colors.dart';
import 'package:client/res/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final IconData? iconData;
  final bool outlined;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onTap,
    this.iconData,
    this.outlined = true,
    this.isLoading = false,
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
          color: !outlined ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
          border:
              outlined ? Border.all(color: Colors.grey.withOpacity(0.3)) : null,
        ),
        child: Center(
          child: isLoading
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (iconData != null)
                      Icon(
                        iconData,
                        color: outlined
                            ? const Color.fromARGB(255, 67, 67, 67)
                            : Colors.white,
                        size: 20.0,
                      ),
                    AppDimens.gap(iconData != null ? 1 : 0), // Adjust spacing
                    Text(
                      text.toUpperCase(),
                      style: TextStyle(
                        letterSpacing: 1.2,
                        color: outlined
                            ? const Color.fromARGB(255, 67, 67, 67)
                            : Colors.white,
                        fontWeight:
                            !outlined ? FontWeight.w600 : FontWeight.w500,
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
