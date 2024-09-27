import 'dart:async';
import 'dart:math'; // Import for generating random OTP
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
import 'package:ev_homes_customer/Wrappers/home_wrapper.dart';
import 'package:ev_homes_customer/provider/dataprovider.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationPage extends StatefulWidget {
  final String? phoneNumber;
  const OtpVerificationPage({super.key, this.phoneNumber});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _controller = TextEditingController();
  final Dataprovider _firestoreDelete = Dataprovider();

  late Timer _timer;
  int _timeRemaining = 120; // 2 minutes = 120 seconds
  bool _isOtpExpired = false;
  bool _isResendAvailable = false;
  String _otp = ''; // Store the OTP here

  @override
  void initState() {
    super.initState();
    _generateOtp(); // Generate OTP when the page loads
    _startTimer();
  }

  // Method to generate a 4-digit random OTP
  void _generateOtp() {
    final random = Random();
    setState(() {
      _otp = (random.nextInt(9000) + 1000)
          .toString(); // Generate a random 4-digit number
    });
    print('Generated OTP: $_otp'); // For debugging purposes
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        setState(() {
          _isOtpExpired = true;
          _timer.cancel(); // Stop the timer when it reaches 0
        });
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _resendOtp() {
    setState(() {
      _isOtpExpired = false;
      _isResendAvailable = false;
      _timeRemaining = 120; // Reset to 2 minutes
    });
    _generateOtp(); // Generate a new OTP when resending
    _startTimer();
    // Logic to send the new OTP to the user's phone goes here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP Resent!')),
    );
  }

  Future<String?> _storeOtpInDatabase(String otp, String phoneNumber) async {
    // Get a reference to the Firestore database
    final CollectionReference otpCollection =
        FirebaseFirestore.instance.collection('otps');

    try {
      // Store OTP and phone number in Firestore
      await otpCollection.add({
        'phoneNumber': phoneNumber,
        'otp': otp,
        'timestamp':
            FieldValue.serverTimestamp(), // To track when the OTP was created
      });

      print('OTP stored successfully in Firestore!');
    } catch (e) {
      print('Error storing OTP in Firestore: $e');
      return null;
    }
    return null;
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'OTP VERIFICATION',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF745C),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter the OTP sent to your phone number',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Pin Code Input Field (4 boxes)
            PinCodeTextField(
              controller: _controller,
              appContext: context,
              length: 4,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 40,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                selectedFillColor: Colors.white,
                activeColor: Color(0xFFFF745C),
                inactiveColor: Color.fromARGB(255, 238, 136, 118),
                selectedColor: Color(0xFFFF745C),
              ),
              keyboardType: TextInputType.number,
              enableActiveFill: true,
            ),
            const SizedBox(height: 20),

            // Verify OTP Button
            ElevatedButton(
              onPressed: _isOtpExpired
                  ? null // Disable the button when OTP is expired
                  : () async {
                      String? otpId = await _storeOtpInDatabase(
                          _otp, widget.phoneNumber ?? '');
                      // Simulate user input matching generated OTP
                      if (_controller.text == _otp) {
                        _storeOtpInDatabase(_otp, widget.phoneNumber ?? '');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeWrapper()),
                        );
                        Timer(const Duration(minutes: 5), () {
                          _firestoreDelete.deleteOtpFromDatabase(otpId!);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid OTP!')),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isOtpExpired ? Colors.grey : const Color(0xFFFF745C),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'VERIFY OTP',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
              ),
            ),

            const SizedBox(height: 20),

            // Timer display
            Text(
              _formatTime(_timeRemaining),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Resend OTP option
            const Text(
              "Didn't receive OTP?",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: _isOtpExpired || _isResendAvailable
                  ? _resendOtp
                  : null, // Resend OTP only when expired or manually available
              child: Text(
                'RESEND OTP',
                style: TextStyle(
                  color: _isOtpExpired || _isResendAvailable
                      ? const Color(0xFFFF745C)
                      : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
