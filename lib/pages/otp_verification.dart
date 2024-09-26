import 'package:ev_homes_customer/Wrappers/home_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key, String? phoneNumber});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
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
            // OTP Verification Title
            const Text(
              'OTP VERIFICATION',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color:  Color(0xFFFF745C),
              ),
            ),
            const SizedBox(height: 20),

            // Instruction text
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
              onChanged: (value) {},
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 40,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                selectedFillColor: Colors.white,
                activeColor: const Color(0xFF385A63),
                inactiveColor: const Color(0xFF385A63),
                selectedColor: const Color(0xFF385A63),
              ),
              keyboardType: TextInputType.number,
              enableActiveFill: true,
            ),
            const SizedBox(height: 20),

            // Verify OTP Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => const HomeWrapper()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF745C),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
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

            // Timer display (dummy value for now)
            const Text(
              '02:00',
              style: TextStyle(
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
              onTap: () {
                // Resend OTP logic goes here (dummy action for now)
              },
              child: const Text(
                'RESEND OTP',
                style: TextStyle(
                  color: Color(0xFFFF745C),
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
