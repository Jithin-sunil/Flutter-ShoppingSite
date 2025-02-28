import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ComplaintPage extends StatefulWidget {
  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedCategory = 'Order Issue';
  File? _image;

  List<String> complaintCategories = [
    'Order Issue',
    'Product Quality',
    'Service Problem',
    'Refund Request',
    'Other'
  ];

  // Function to Pick Image
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to Submit Complaint
  void submitComplaint() {
    if (_formKey.currentState!.validate()) {
      // Handle Complaint Submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Complaint Submitted Successfully!')),
      );
      // Clear Form
      titleController.clear();
      descriptionController.clear();
      setState(() {
        _image = null;
        selectedCategory = 'Order Issue';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Complaint'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Complaint Category",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              DropdownButtonFormField(
                value: selectedCategory,
                items: complaintCategories.map((category) {
                  return DropdownMenuItem(value: category, child: Text(category));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value.toString();
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),

              Text(
                "Complaint Title",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: titleController,
                validator: (value) => value!.isEmpty ? 'Title cannot be empty' : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Complaint Title",
                ),
              ),
              SizedBox(height: 15),

              Text(
                "Complaint Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                validator: (value) => value!.isEmpty ? 'Description cannot be empty' : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Explain the issue...",
                ),
              ),
              SizedBox(height: 15),

              Text(
                "Attach Screenshot (Optional)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: pickImage,
                    icon: Icon(Icons.image),
                    label: Text("Upload Image"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                    ),
                  ),
                  SizedBox(width: 10),
                  _image != null
                      ? Image.file(_image!, width: 80, height: 80, fit: BoxFit.cover)
                      : Text("No image selected"),
                ],
              ),
              SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: submitComplaint,
                  child: Text('Submit Complaint', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
