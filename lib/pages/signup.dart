import 'package:ev_homes_customer/pages/login_page.dart';
import 'package:flutter/material.dart';

class SignUpTabBarPage extends StatelessWidget {
  const SignUpTabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SignUpTabBar(
            emailAddressTextController: TextEditingController(),
            emailAddressFocusNode: FocusNode(),
            emailAddressValidatorFocusNode: FocusNode(),
            passwordController: TextEditingController(),
            passwordFocusNode: FocusNode(),
            passwordVisibility: false,
            onPressPassVisibility: () {},
            onPressSignup: () {
              // Do signup action here
            },
            passwordValidator: (value) => null,
            emailValidator: (value) => null,
          ),
        ),
      ),
    );
  }
}

class SignUpTabBar extends StatefulWidget {
  final TextEditingController emailAddressTextController;
  final FocusNode emailAddressFocusNode;
  final FocusNode emailAddressValidatorFocusNode;
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final bool passwordVisibility;
  final Function() onPressPassVisibility;
  final Function() onPressSignup;
  final String? Function(String?)? passwordValidator;
  final String? Function(String?)? emailValidator;

  const SignUpTabBar({
    super.key,
    required this.emailAddressTextController,
    required this.emailAddressFocusNode,
    required this.emailAddressValidatorFocusNode,
    required this.passwordController,
    required this.passwordFocusNode,
    required this.passwordVisibility,
    required this.onPressPassVisibility,
    required this.onPressSignup,
    this.passwordValidator,
    this.emailValidator,
  });

  @override
  _SignUpTabBarState createState() => _SignUpTabBarState();
}

class _SignUpTabBarState extends State<SignUpTabBar>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _shinyAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for the shiny animation
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);

    _shinyAnimation =
        Tween<double>(begin: -1, end: 2).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              // Logo
              // Center(
              //   child: Image.asset(
              //     'assets/images/evicon.png', // Replace with your logo path
              //     width: 130, // Adjust width as needed
              //   ),
              // ),

              // const SizedBox(height: 20),

              // const Text(
              //   'Sign up',
              //   style: TextStyle(
              //     fontSize: 32,
              //     color: Colors.black,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              const SizedBox(height: 8),

              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                   fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              // Name field
              _buildTextField(
                label: 'Name',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Email field
              _buildTextField(
                label: 'Email address',
                icon: Icons.email,
                controller: widget.emailAddressTextController,
                focusNode: widget.emailAddressFocusNode,
                keyboardType: TextInputType.emailAddress,
                validator: widget.emailValidator ?? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.contains('@')) {
                    return 'Invalid email address';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Phone number field
              _buildPhoneNumberField(),

              const SizedBox(height: 32),

              // Register Button with Shiny Animation
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onPressSignup();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 16,
                        ),
                        backgroundColor: const Color(0xFFFF745C), // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: _shinyAnimation,
                        builder: (context, child) {
                          return ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.0),
                                  Colors.white.withOpacity(0.8), // Increased opacity
                                  Colors.white.withOpacity(0.0),
                                ],
                                stops: [
                                  _shinyAnimation.value - 0.2, // Adjusted stop values
                                  _shinyAnimation.value,
                                  _shinyAnimation.value + 0.2,
                                ],
                                begin: Alignment.topLeft, // Top left for 45 degrees
                                end: Alignment.bottomRight, // Bottom right for 45 degrees
                              ).createShader(bounds);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Login prompt
               Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Alreday have an account?",
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(), // Ensure this is your actual signup page
                      ),
                    );
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }

  // Phone number text field with +91 prefix, phone icon, and custom styling
  Widget _buildPhoneNumberField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      maxLength: 10,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Phone Number',
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: const Icon(Icons.phone, color: Colors.black),
        prefixText: '+91 ',
        prefixStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
        ),
        counterText: '', // Removes the '0/10' counter text
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        } else if (value.length != 10) {
          return 'Phone number must be 10 digits';
        }
        return null;
      },
    );
  }

  // Helper to create custom-styled text fields
  Widget _buildTextField({
    required String label,
    required IconData icon,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: Icon(icon, color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
        ),
      ),
      validator: validator,
    );
  }
}
