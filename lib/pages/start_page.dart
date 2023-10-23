import 'package:flutter/material.dart';
import 'package:mediguard/shared/theme.dart';

import '../widgets/custom_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo.png",
            width: 128,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Medi',
                style: whiteText.copyWith(
                  fontSize: 36,
                  fontWeight: regular,
                ),
              ),
              Text(
                'Guard',
                style: whiteText.copyWith(
                  fontSize: 36,
                  fontWeight: bold,
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ready for today\'s ',
                style: whiteText.copyWith(
                  fontSize: 14,
                  fontWeight: regular,
                ),
              ),
              Text(
                'adventure? 🗺️',
                style: whiteText.copyWith(
                  fontSize: 14,
                  fontWeight: bold,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: CustomButton(
              marginTop: 32,
              marginBottom: 16,
              buttonColor: Colors.white,
              buttonText: "Scan MediGuard",
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/main', (route) => false);
              },
              textStyle: primaryText,
            ),
          ),
        ],
      ),
    );
  }
}
