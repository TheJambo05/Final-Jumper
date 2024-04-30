import 'package:flutter/material.dart';
import 'package:jumper/presentation/widgets/user/primary_button.dart';
import 'package:jumper/presentation/widgets/user/primary_textfield.dart';

class EditUserProfileScreen extends StatefulWidget {
  const EditUserProfileScreen({super.key});

  static const String routeName = "edit_user_profile";

  @override
  State<EditUserProfileScreen> createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: "User");
  final TextEditingController _emailController =
      TextEditingController(text: "user@gmail.com");
  final TextEditingController _phoneController =
      TextEditingController(text: "9804120747");
  final TextEditingController _addressController =
      TextEditingController(text: "Pokhara");
  final TextEditingController _roleController =
      TextEditingController(text: "user");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Implement the logic to save the user data here
              // This might involve updating a database or calling a network request
              // Show a confirmation message
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile saved successfully!')));
              // Optionally navigate back to the previous screen or refresh the data
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/CV.jpg"),
                radius: 70,
              ),
            ),
            const SizedBox(height: 10),
            PrimaryTextField(
              labelText: "Name",
              controller: _nameController,
            ),
            const SizedBox(height: 10),
            PrimaryTextField(
              labelText: "Email",
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            PrimaryTextField(
              labelText: "Phone Number",
              controller: _phoneController,
            ),
            const SizedBox(height: 10),
            PrimaryTextField(
              labelText: "Address",
              controller: _addressController,
            ),
            const SizedBox(height: 10),
            PrimaryTextField(
              labelText: "Role",
              controller: _roleController,
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: "Save",
              onPressed: () {
                // You can replicate the save logic here or handle other specific actions
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _roleController.dispose();
    super.dispose();
  }
}
