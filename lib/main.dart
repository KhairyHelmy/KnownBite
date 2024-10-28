import 'package:flutter/material.dart';
import 'package:flutter_application_/screens/donor/donor_main.dart';
import 'package:flutter_application_/screens/donor/make_donation.dart';
import 'package:flutter_application_/screens/home/details.dart';
import 'package:flutter_application_/screens/home/login.dart';
import 'package:flutter_application_/screens/home/selectProfile.dart';
import 'package:flutter_application_/screens/home/signup.dart';

/* 
  TODO: We need 3 packages to install from pub.dev
    1. google_fonts: ^6.2.1 (https://pub.dev/packages/google_fonts)
    2. google_generative_ai: ^0.4.6 (https://pub.dev/packages/google_generative_ai)
    3. image_picker: ^0.8.4+4 (https://pub.dev/packages/image_picker)
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: false,
      ),
      initialRoute: '/login', //Set initial route to sign-up page
      routes: {
        '/signup': (context) => const SignUpScreen(),
        '/login' : (context) => const LoginScreen(),
        '/selectProfile' : (context) => const SelectProfileScreen(),
        '/details' : (context) => const DetailsScreen(),
        '/donor_screen' : (context) => const DonorScreen(),
        '/makedonation_screen' : (context) => MakeDonationScreen(),
      },
      //home: const SignUpScreen(),
    );
  }
}