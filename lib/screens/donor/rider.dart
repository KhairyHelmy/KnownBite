import 'package:flutter/material.dart';
import 'package:location/location.dart';

class RiderTrackingScreen extends StatefulWidget {
  const RiderTrackingScreen({super.key});

  @override
  _RiderTrackingScreenState createState() => _RiderTrackingScreenState();
}

class _RiderTrackingScreenState extends State<RiderTrackingScreen> {
  LocationData? _currentLocation;
  late Location location;

  @override
  void initState() {
    super.initState();
    location = Location();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if GPS is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    // Check for location permission
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    // Get the current location
    _currentLocation = await location.getLocation();

    // Update location on change
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentLocation = currentLocation;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Live tracking'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Placeholder for the map
                Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      _currentLocation != null
                          ? 'Location: Lat ${_currentLocation!.latitude}, Lng ${_currentLocation!.longitude}'
                          : 'Fetching location...',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                // Simulated route and destination pins (replace with actual map)
                Positioned(
                  top: 50,
                  left: 100,
                  child: Icon(Icons.location_on, color: Colors.green[700], size: 50),
                ),
                const Positioned(
                  top: 200,
                  right: 100,
                  child: Icon(Icons.location_pin, color: Colors.red, size: 50),
                ),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 25,
                    ),
                    title: const Text('Ayush Pant', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('I am pickup volunteer'),
                    trailing: const Icon(Icons.keyboard_arrow_down),
                  ),
                  const SizedBox(height: 10),
                  const Text("ID Details - 324800", style: TextStyle(color: Colors.black54)),
                  const Text("Contact - 9011234560", style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green[700]),
                          const SizedBox(height: 4),
                          const Text("Assigned", style: TextStyle(fontSize: 12)),
                          const Text("10:00 PM", style: TextStyle(fontSize: 12, color: Colors.black54)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green[700]),
                          const SizedBox(height: 4),
                          const Text("Pick Up", style: TextStyle(fontSize: 12)),
                          const Text("10:00 PM", style: TextStyle(fontSize: 12, color: Colors.black54)),
                        ],
                      ),
                      const Column(
                        children: [
                          Icon(Icons.radio_button_unchecked, color: Colors.grey),
                          SizedBox(height: 4),
                          Text("Complete order", style: TextStyle(fontSize: 12)),
                          Text("10:00 PM", style: TextStyle(fontSize: 12, color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.phone, color: Colors.green[700]),
                        onPressed: () {
                          // Add call functionality
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add message functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                        ),
                        child: const Text("Send message"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add tip functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                        ),
                        child: const Text("+Tip"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

