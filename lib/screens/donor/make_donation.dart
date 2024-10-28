import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MakeDonationScreen extends StatefulWidget {
  @override
  _MakeDonationScreenState createState() => _MakeDonationScreenState();
}

class _MakeDonationScreenState extends State<MakeDonationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _expirationTimeController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<File> _selectedImages = []; // List to store selected images
  int _vegQuantity = 0;
  int _nonVegQuantity = 0;
  bool _assuranceChecked = false;
  String _selectedFoodType = 'Cooked Food-Veg & NonVeg';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _expirationDateController.dispose();
    _expirationTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _expirationDateController.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _expirationTimeController.text = picked.format(context);
      });
    }
  }

   Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path)); // Add selected image to the list
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _assuranceChecked) {
      // Handle form submission logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Donation listed successfully!')),
      );
    } else if (!_assuranceChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please assure the quality and hygiene of the food.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Add Title',
                  hintText: 'Add food title',
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Eg: Tomatoes from the garden',
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedFoodType,
                decoration: InputDecoration(labelText: 'Type of Food'),
                items: [
                  'Cooked Food-Veg & NonVeg',
                  'Cooked Food-Veg Only',
                  'Cooked Food-NonVeg Only',
                  'Raw Food Items'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFoodType = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                'Food Quantity',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Checkbox(
                          value: _vegQuantity > 0,
                          onChanged: (bool? value) {
                            setState(() {
                              _vegQuantity = value! ? 1 : 0;
                            });
                          },
                        ),
                        Expanded(child: Text('Veg')),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (_vegQuantity > 0) _vegQuantity--;
                            });
                          },
                        ),
                        Text('$_vegQuantity'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _vegQuantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Checkbox(
                          value: _nonVegQuantity > 0,
                          onChanged: (bool? value) {
                            setState(() {
                              _nonVegQuantity = value! ? 1 : 0;
                            });
                          },
                        ),
                        Expanded(child: Text('Non-Veg')),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (_nonVegQuantity > 0) _nonVegQuantity--;
                            });
                          },
                        ),
                        Text('$_nonVegQuantity'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _nonVegQuantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Photos:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  ..._selectedImages.map((image) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.file(
                        image,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                  IconButton(
                    icon: Icon(Icons.add_a_photo, color: Colors.grey[700]),
                    onPressed: _pickImage,
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _expirationDateController,
                decoration: InputDecoration(
                  labelText: 'Expiration Date',
                  hintText: 'Select expiration date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an expiration date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _expirationTimeController,
                decoration: InputDecoration(
                  labelText: 'Expiration Time',
                  hintText: 'Select expiration time',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () => _selectTime(context),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an expiration time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                title: Text('I assure that the food quality and hygiene has been maintained'),
                value: _assuranceChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _assuranceChecked = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(height: 16),
              
              SizedBox(
              width:double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Submit', style: TextStyle(fontSize: 16)),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
