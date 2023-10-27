import 'package:flutter/material.dart';
import 'package:mediguard/shared/theme.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final Color buttonColor;
  final TextStyle textStyle;
  final double marginTop;
  final double marginBottom;
  final IconData? icon;

  const CustomButton({
    Key? key,
    required this.buttonColor,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      width: double.infinity,
      height: 36,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: icon != null,
              child: Icon(
                icon,
                size: 20,
                color: Colors.white,
              ),
            ),
            Visibility(
              visible: icon != null,
              child: const SizedBox(width: 8),
            ),
            Text(
              buttonText,
              style: textStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
