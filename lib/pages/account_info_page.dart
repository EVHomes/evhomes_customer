// import 'package:ev_homes_crm_v7/core/providers/setting_provider.dart';
import 'package:ev_homes_customer/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    // Initial data for the profile
    final loggedUser =
        Provider.of<SettingProvider>(context, listen: false).loggedUser;

    _nameController.text = loggedUser?.name ?? "Unkown";
    _emailController.text = loggedUser?.email ?? "Unkown";
    _phoneController.text = loggedUser?.phoneNumber ?? "Unkown";
    _addressController.text = loggedUser?.homeAddress ?? "Unkown";
    _reraNoController.text = loggedUser?.reraNumber ?? "Rera not Registered";
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
    final loggedUser = Provider.of<SettingProvider>(context).loggedUser;

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
            Text(
              loggedUser?.name ?? "Unkown",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            Text(
              loggedUser?.email ?? "mahek@example.com",
              style: const TextStyle(color: Colors.deepPurple),
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
