import 'package:flutter/material.dart';
import 'package:flutter_application_/screens/donor/rider.dart';

class ReceiverScreen extends StatefulWidget {
  const ReceiverScreen({super.key});

  @override
  _ReceiverScreenState createState() => _ReceiverScreenState();
}

class _ReceiverScreenState extends State<ReceiverScreen> {
  String selectedRole = 'Receiver'; // Default role
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 34, 139, 34), // Dark green
      //   elevation: 0,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text('Hi Mandeep', style: TextStyle(color: Colors.white)),
      //       Icon(Icons.notifications_none, color: Colors.white),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Role and Points section with Dropdown icon
            const SizedBox(height: 35),
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Hi Mandeep', style: TextStyle(color: Colors.black, fontSize: 18)),
            Icon(Icons.notifications_none, color: Colors.black),
          ],
        ),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: 'You are a ',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                    children: [
                      TextSpan(
                        text: selectedRole,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatisticColumn('No of Donations', '50'),
                  _buildStatisticColumn('Feedback Received', '25'),
                  _buildStatisticColumn('Points Earned', '556'),
                ],
              ),
            ),
            SizedBox(height: 16),

            // My Post and Receiver Requests Tabs
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('My Donations', style: TextStyle(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () => _showReceiverRequestDialog(context),
                child: Text(
                  'Receiver Requests',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[800]),
                ),
              ),
            ],
          ),

            SizedBox(height: 16),

            // Create Donation Post
            Center(
              child: Column(
                children: [
                  Text("Nothing till now", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8),
                  Text("Do you have some food to donate?"),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {Navigator.pushNamed(context, '/makedonation_screen');},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      backgroundColor: Color(0xFF388E3C), // Modern green button
                    ),
                    child: Text('+ Make a donation today', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Donation History Section
            _buildSectionTitle('Donation History', 'View all'),
            SizedBox(height: 10),
            _buildDonationHistoryItem('324800', '2 Days Ago', 'Meat', '2 Pack', 'Non Veg'),
            SizedBox(height: 16),

            // FAQs Section
            _buildSectionTitle('FAQs', ''),
            _buildFaqItem('Who will pick up the food?'),
            _buildFaqItem('Can we perform one-time donations?'),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      // ),
    );
  }

  Widget _buildStatisticColumn(String title, String value) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: Colors.grey)),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSectionTitle(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        if (actionText.isNotEmpty)
          Text(actionText, style: TextStyle(color: Colors.blue)),
      ],
    );
  }

 Widget _buildDonationHistoryItem(String id, String date, String description, String quantity, String type) {
  return ListTile(
    leading: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          image: AssetImage('assets/meat.jpeg'), // Replace with the actual image path or network image
          fit: BoxFit.cover,
        ),
      ),
    ),
    title: Text('ID: $id'),
    subtitle: Text('$description\n$quantity • $type'),
    trailing: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(date, style: TextStyle(fontSize: 12, color: Colors.grey)),
        Text('Completed', style: TextStyle(color: Colors.green)),
      ],
    ),
  );
}

  Widget _buildFaqItem(String question) {
    return ExpansionTile(
      title: Text(question),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Answer goes here.'),
        ),
      ],
    );
  }
}

void _showReceiverRequestDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          'Receiver Requests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.group, color: Colors.blue),
                title: Text("Receiver: NGO HelpAid"),
                subtitle: Text("Request made for 20 meals"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.person, color: Colors.green),
                title: Text("Assigned Rider: John Doe"),
                subtitle: Text("Rider Contact: 123-456-7890"),
              ),
              SizedBox(height: 10), // Add space before the button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  _navigateToRiderDetails(context); // Pass context here
                },
                child: Text("View Rider Details"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green[600], // Text color
                  minimumSize: Size(double.infinity, 40), // Make button full width
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              "Close",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      );
    },
  );
}


void _navigateToRiderDetails(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RiderTrackingScreen()),
  );
}

