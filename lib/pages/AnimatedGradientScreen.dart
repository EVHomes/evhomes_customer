// import 'package:ev_homes_crm_v7/core/constant/constant.dart';
import 'package:ev_homes_customer/core/constant.dart';
import 'package:flutter/material.dart';

class AnimatedGradient extends StatefulWidget {
  @override
  _AnimatedGradientState createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient> {
  // Define the colors for the gradient
  List<Color> gradientColors = [
    const Color.fromARGB(255, 42, 9, 99),
    const Color.fromARGB(255, 109, 31, 122),
    Color(0xFFB8860B),
    Constant.bgColor,
  ];

  @override
  void initState() {
    super.initState();
    // Start the gradient animation
    _startAnimation();
  }

  void _startAnimation() {
    // Periodically change the gradient colors
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        gradientColors =
            gradientColors.reversed.toList(); // Reverse the gradient colors
      });
      _startAnimation(); // Recursively call to create an endless loop
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2), // Duration for color change
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(), // You can add content inside this container if needed
    );
  }
}
