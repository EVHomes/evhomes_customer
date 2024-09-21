import 'package:flutter/material.dart';

class AccountProfilePage extends StatefulWidget {
  const AccountProfilePage({super.key});

  @override
  State<AccountProfilePage> createState() => _AccountProfilePageState();
}

class _AccountProfilePageState extends State<AccountProfilePage> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _reraNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Dummy data for the profile
    _nameController.text = "John Doe";
    _emailController.text = "johndoe@example.com";
    _phoneController.text = "+1 234 567 890";
    _addressController.text = "123 Main St, Springfield";
    _reraNoController.text = "RERA123456";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _reraNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile picture
            CircleAvatar(
              radius: 60.0,
              backgroundImage: const NetworkImage('https://picsum.photos/200'),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 20.0),

            // Username
            const Text(
              "John Doe",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            const Text(
              "johndoe@example.com",
              style: TextStyle(color: Colors.deepPurple),
            ),
            const SizedBox(height: 20.0),

            // Non-editable fields
            _buildTextField('Name', _nameController),
            const SizedBox(height: 10.0),
            _buildTextField('Email', _emailController),
            const SizedBox(height: 10.0),
            _buildTextField('Phone', _phoneController),
            const SizedBox(height: 10.0),
            _buildTextField('Address', _addressController),
            const SizedBox(height: 10.0),
            _buildTextField('Rera Number', _reraNoController),
          ],
        ),
      ),
    );
  }

  // Function to build non-editable text field
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true, // Make the text field non-editable
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
