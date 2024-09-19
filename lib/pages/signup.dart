import 'package:flutter/material.dart';
import 'package:ev_homes_customer/core/theme_colors.dart';
import 'package:ev_homes_customer/pages/otp_verification.dart';

class SignUpTabBarPage extends StatelessWidget {
  const SignUpTabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SignUpTabBar(
        emailAddressTextController: TextEditingController(),
        emailAddressFocusNode: FocusNode(),
        emailAddressValidatorFocusNode: FocusNode(),
        passwordController: TextEditingController(),
        passwordFocusNode: FocusNode(),
        passwordVisibility: false,
        onPressPassVisibility: () {},
        onPressSignup: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OtpVerificationPage(phoneNumber: '')), // Pass an empty phone number for now
          );
        },
        passwordValidator: (value) => null,
        emailValidator: (value) => null,
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

class _SignUpTabBarState extends State<SignUpTabBar> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(
        0.0,
        -1.0,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          24.0,
          16.0,
          24.0,
          24.0,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 230.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: ThemeColors.secondaryBackground,
                  ),
                ),
                
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    0.0,
                    4.0,
                    0.0,
                    24.0,
                  ),
                  child: Text(
                    style: TextStyle(
                      fontSize:  18,
                    ),
                    ' create an new account',
                    textAlign: TextAlign.justify,
                  ),
                ),

                // name textfield
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      autofocus: true,
                      autofillHints: const [AutofillHints.name],
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.deepPurpleAccent,
                            width: 1.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 1.0,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.fromLTRB(
                          0,
                          16.0,
                          0,
                          4.0,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                // email textfield
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      controller: widget.emailAddressTextController,
                      focusNode: widget.emailAddressFocusNode,
                      autofocus: true,
                      autofillHints: const [AutofillHints.email],
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.deepPurpleAccent,
                            width: 1.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 1.0,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                          right: 16.0,
                          bottom: 4.0,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@')) {
                          return 'Invalid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                ),

               // phone number textfield
Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
  child: SizedBox(
    width: double.infinity,
    child: TextFormField(
      autofocus: true,
      autofillHints: const [AutofillHints.telephoneNumber],
      obscureText: false,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        prefixIcon: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 15,),
            Icon(Icons.call),
            SizedBox(width: 4), // Add a small space between the icon and the text
            VerticalDivider(thickness: 1, color: Colors.grey),
            SizedBox(width: 4), // Add a small space between the divider and the text
            Text(
              '+91',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.deepPurpleAccent,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.0,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(
          0,
          16.0,
          0,
          4.0,
        ),
      ),
      style: const TextStyle(
        color: Color.fromARGB(
          252,
          0,
          0,
          0,
        ),
        fontSize: 16,
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        } else if (value.length < 10) {
          return 'Invalid phone number';
        }
        return null;
      },
    ),
  ),
),

                // request btn
Align(
  alignment: const AlignmentDirectional(0.0, 0.0),
  child: Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
    child: ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          widget.onPressSignup();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OtpVerificationPage()),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, // Button text color
        backgroundColor: Colors.purple, // Button background color
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: const Text(
        'sign up',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    ),
  ),
),
              ],
            ),
          ),
        ),
      ),
    );
  }
}