import 'package:everyattire/constants/color_constants.dart';
import 'package:everyattire/providers/auth_provider.dart';
import 'package:everyattire/providers/products_provider.dart';
import 'package:everyattire/screens/authentication_screen/login_screen.dart';
import 'package:everyattire/screens/authentication_screen/register_screen.dart';
import 'package:everyattire/screens/homepage.dart';
import 'package:everyattire/screens/onboarding_screen/intro_page_1.dart';
import 'package:everyattire/screens/onboarding_screen/onboarding_screen.dart';
import 'package:everyattire/screens/onboarding_screen/splash_screen.dart';
import 'package:flutter/material.dart';
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
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Every Attire',
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBGColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Homepage(),
      ),
    );
  }
}
