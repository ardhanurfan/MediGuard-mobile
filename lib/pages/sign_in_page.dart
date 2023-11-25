import 'package:flutter/material.dart';
import 'package:mediguard/shared/theme.dart';
import 'package:mediguard/widgets/custom_button.dart';

import '../widgets/custom_form_field.dart';
import '../widgets/header.dart';
import '../widgets/logo_horizontal.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return ListView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.15,
          right: paddingHorizontal,
          left: paddingHorizontal,
          bottom: paddingHorizontal,
        ),
        children: [
          const LogoHorizontal(),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.075),
            padding: EdgeInsets.all(paddingHorizontal),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 0.5,
                  )
                ]),
            child: Column(
              children: [
                Text(
                  'Sign In to Continue',
                  style: greyText.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(height: 28),
                CustomFormField(
                  hintText: 'Input your email',
                  label: 'Email',
                  validator: 'Please input your email',
                  textController: emailController,
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  hintText: 'Input your password',
                  label: 'Password',
                  validator: 'Please input your password',
                  textController: passwordController,
                  isPassword: true,
                ),
                CustomButton(
                  marginTop: 32,
                  marginBottom: 16,
                  buttonColor: primaryColor,
                  buttonText: "Log In",
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/start', (route) => false);
                  },
                  textStyle: whiteText,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Reset Password',
                      style: greyText.copyWith(
                        fontSize: 12,
                        fontWeight: regular,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       'New Member? ',
          //       style: primaryText.copyWith(
          //         fontSize: 12,
          //         fontWeight: regular,
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () => Navigator.pushNamed(context, '/sign-up'),
          //       child: Text(
          //         'Sign Up Here',
          //         style: secondaryText.copyWith(
          //           fontSize: 12,
          //           fontWeight: regular,
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          const Header(
            height: 0.33,
          ),
          body(),
        ],
      ),
    );
  }
}
