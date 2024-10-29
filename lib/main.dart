import 'package:flutter/material.dart';
import 'package:flutter_application_/screens/donor/donor_main.dart';
import 'package:flutter_application_/screens/donor/make_donation.dart';
import 'package:flutter_application_/screens/home/details.dart';
import 'package:flutter_application_/screens/home/login.dart';
import 'package:flutter_application_/screens/home/selectProfile.dart';
import 'package:flutter_application_/screens/home/signup.dart';
import 'package:flutter_application_/screens/receiver/receiver_main.dart';
import 'package:flutter_application_/screens/volunteer/volunteer_main.dart';

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
      home: MainScreen(),
     //initialRoute: '/main_screen', //Set initial route to sign-up page
      routes: {
        '/main_screen' : (context) => MainScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/login' : (context) => const LoginScreen(),
        '/selectProfile' : (context) => const SelectProfileScreen(),
        '/details' : (context) => const DetailsScreen(),
        '/donor_screen' : (context) => const DonorScreen(),
        '/makedonation_screen' : (context) => const MakeDonationScreen(),
      },
      //home: const SignUpScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // Index of the current tab
  //String selectedRole = 'Donor'; // Default role

  final List<Widget> _screens = [
    const DonorPage(),
    const ReceiverPage(),
    const VolunteerPage(),
    const SelectProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Donor'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Receiver'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Volunteer'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// Placeholder pages for different roles
class DonorPage extends StatelessWidget {
  const DonorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DonorScreen();
  }
}

class ReceiverPage extends StatelessWidget {
  const ReceiverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReceiverScreen();
  }
}

class VolunteerPage extends StatelessWidget {
  const VolunteerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const VolunteerScreen();
  }
}
