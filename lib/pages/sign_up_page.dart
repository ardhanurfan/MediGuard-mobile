import 'package:flutter/material.dart';
import 'package:mediguard/shared/theme.dart';
import 'package:mediguard/widgets/custom_button.dart';
import 'package:mediguard/widgets/logo_horizontal.dart';

import '../widgets/custom_form_field.dart';
import '../widgets/header.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                  'Create an Account',
                  style: greyText.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(height: 28),
                CustomFormField(
                  hintText: 'Input your full name',
                  label: 'Full Name',
                  validator: 'Please input your full name',
                  textController: fullNameController,
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                CustomFormField(
                  hintText: 'Input your confirm password',
                  label: 'Confirm Password',
                  validator: 'Please input your confirm password',
                  textController: confirmPasswordController,
                  isPassword: true,
                ),
                CustomButton(
                  marginTop: 32,
                  marginBottom: 16,
                  buttonColor: primaryColor,
                  buttonText: "Create Account",
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/start', (route) => false);
                  },
                  textStyle: whiteText,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Have an account? ',
                style: primaryText.copyWith(
                  fontSize: 12,
                  fontWeight: regular,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/sign-in'),
                child: Text(
                  'Sign In Here',
                  style: secondaryText.copyWith(
                    fontSize: 12,
                    fontWeight: regular,
                  ),
                ),
              ),
            ],
          )
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
