import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int selectedDonorType = 0;

  // Define a list of donor types
  final List<Map<String, dynamic>> donorTypes = [
    {'icon': Icons.restaurant, 'label': 'Restaurant'},
    {'icon': Icons.bakery_dining, 'label': 'Bakery'},
    {'icon': Icons.person, 'label': 'Individual'},
    {'icon': Icons.business, 'label': 'Business'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 139, 34), // Dark green
        elevation: 0,
        title: const Text(
          'Donor Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Donor Type Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(donorTypes.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDonorType = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: 80,
                    decoration: BoxDecoration(
                      color: selectedDonorType == index ? Colors.green[200] : Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Icon(donorTypes[index]['icon'], size: 32, color: Colors.green[800]),
                        const SizedBox(height: 8),
                        Text(donorTypes[index]['label'],
                            style: TextStyle(fontSize: 12, color: selectedDonorType == index ? Colors.black : Colors.grey)),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Show different forms based on donor type
            if (selectedDonorType == 2) // If "Individual" is selected
              _buildIndividualForm()
            else
              _buildBusinessForm(),

            const SizedBox(height: 16),

            // Pin Location Option
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Divider(color: Colors.grey)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Or', style: TextStyle(color: Colors.grey)),
                ),
                Expanded(child: Divider(color: Colors.grey)),
              ],
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Pin Location by map',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/donor_screen');
                  },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                  backgroundColor: const Color(0xFF388E3C), // Modern green button
                ),
                child: const Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method for the Individual form
  Widget _buildIndividualForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Full Name'),
        _buildTextField('Contact Number'),
        _buildTextField('Email Id'),
        _buildTextField('Address'),
      ],
    );
  }

  // Method for the Business form
  Widget _buildBusinessForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Business Name'),
        _buildTextField('Contact Name (Optional)'),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '+91',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: _buildTextField('Mobile Number'),
            ),
          ],
        ),
        _buildTextField('Email Id'),
        _buildTextField('Address'),
        _buildTextField('Pin Code'),
        _buildTextField('City'),
      ],
    );
  }

  // Custom Text Field Widget
  Widget _buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 56, 142, 60)),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}