import 'package:flutter/material.dart';
import 'package:mediguard/pages/main_page.dart';
import 'package:mediguard/pages/sign_in_page.dart';
import 'package:mediguard/pages/sign_up_page.dart';
import 'package:mediguard/pages/splash_page.dart';
import 'package:mediguard/pages/start_page.dart';
import 'package:mediguard/providers/sensor_provider.dart';
import 'package:mediguard/shared/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SensorProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            primaryColor: primaryColor,
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor)),
        routes: {
          '/': (context) => const SplashPage(),
          '/main': (context) => const MainPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/start': (context) => const StartPage(),
        },
      ),
    );
  }
}
