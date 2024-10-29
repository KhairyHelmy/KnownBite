import 'package:flutter/material.dart';

class SelectProfileScreen extends StatefulWidget {
  const SelectProfileScreen({super.key});

  @override
  State<SelectProfileScreen> createState() => _SelectProfileScreenState();
}

class _SelectProfileScreenState extends State<SelectProfileScreen> {
  String selectedRole = 'Donor'; // Default selected role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('KnownBite'),
      //   centerTitle: true,
      //   backgroundColor: Colors.green[700],
      // ),
      
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Text(
              "KnownBite",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Join us in reducing food waste and helping those in need.",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 40),
            Text(
              "Choose your role",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 20),
            // Role selection
            Expanded(
              child: Column(
                children: [
                  roleOption('Donor', 'Donate some food to the needy'),
                  const SizedBox(height: 10),
                  roleOption('Receiver', 'Pickup or receive food'),
                  const SizedBox(height: 10),
                  roleOption('Volunteer', 'Help in food distribution'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle the Continue button action
                  Navigator.pushNamed(context, '/details');
                  print("Selected role: $selectedRole");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  fixedSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget to create role options
  Widget roleOption(String role, String description) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          color: selectedRole == role ? Colors.green[50] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedRole == role ? Colors.green[700]! : Colors.grey[400]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Checkbox(
              value: selectedRole == role,
              onChanged: (bool? value) {
                setState(() {
                  selectedRole = role;
                });
              },
              activeColor: Colors.green[700],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}