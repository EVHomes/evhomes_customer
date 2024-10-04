import 'dart:math';
// import 'package:ev_homes_crm_v7/core/constant/constant.dart';
import 'package:ev_homes_customer/core/constant.dart';
import 'package:flutter/material.dart';

class AnimatedShapesPage extends StatefulWidget {
  @override
  _AnimatedShapesPageState createState() => _AnimatedShapesPageState();
}

class _AnimatedShapesPageState extends State<AnimatedShapesPage>
    with SingleTickerProviderStateMixin {
  //Define the colors for the gradient
  List<Color> gradientColors = [
    Constant.bgColor
    // const Color.fromARGB(255, 42, 9, 99),
    // const Color.fromARGB(255, 109, 31, 122),
    // const Color.fromARGB(255, 236, 191, 25),
  ];

  late AnimationController _controller;
  late Animation<double> _animationX1;
  late Animation<double> _animationY1;
  late Animation<double> _animationX2;
  late Animation<double> _animationY2;
  late Animation<double> _animationX3;
  late Animation<double> _animationY3;
  late Animation<Color?> _gradientAnimation;

  final Random random = Random();

  double screenWidth = 0.0;
  double screenHeight = 0.0;

  double startX1 = 0.0;
  double startY1 = 0.0;
  double endX1 = 0.0;
  double endY1 = 0.0;

  double startX2 = 0.0;
  double startY2 = 0.0;
  double endX2 = 0.0;
  double endY2 = 0.0;

  double startX3 = 0.0;
  double startY3 = 0.0;
  double endX3 = 0.0;
  double endY3 = 0.0;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Start the animation loop
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _setRandomPositions();
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _setRandomPositions();
        _controller.forward();
      }
    });

    _startAnimation();

    // Gradient animation for color transition
    _gradientAnimation = ColorTween(
      begin: gradientColors[0],
      end: gradientColors[0],
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  // Function to set random start and end positions for the shapes
  void _setRandomPositions() {
    setState(() {
      startX1 = random.nextDouble() * (screenWidth - 50);
      startY1 = random.nextDouble() * (screenHeight - 50);
      endX1 = random.nextDouble() * (screenWidth - 50);
      endY1 = random.nextDouble() * (screenHeight - 50);

      startX2 = random.nextDouble() * (screenWidth - 50);
      startY2 = random.nextDouble() * (screenHeight - 50);
      endX2 = screenWidth - random.nextDouble() * (screenWidth - 50);
      endY2 = screenWidth - random.nextDouble() * (screenHeight - 50);

      startX3 = random.nextDouble() * (screenWidth - 50);
      startY3 = random.nextDouble() * (screenHeight - 50);
      endX3 = random.nextDouble() * (screenWidth - 50);
      endY3 = screenHeight - random.nextDouble() * (screenHeight - 50);
    });
  }

  void _startAnimation() {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    _animationX1 =
        Tween<double>(begin: startX1, end: endX1).animate(_controller);
    _animationY1 =
        Tween<double>(begin: startY1, end: endY1).animate(_controller);

    _animationX2 =
        Tween<double>(begin: startX2, end: endX2).animate(_controller);
    _animationY2 =
        Tween<double>(begin: startY2, end: endY2).animate(_controller);

    _animationX3 =
        Tween<double>(begin: startX3, end: endX3).animate(_controller);
    _animationY3 =
        Tween<double>(begin: startY3, end: endY3).animate(_controller);

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background that animates between two colors
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _gradientAnimation.value ?? gradientColors[0], // First color
                  gradientColors[0], // Middle color
                  gradientColors[0], // End color
                ],
                // begin: Alignment.topLeft,
                // end: Alignment.bottomRight,
              ),
            ),
          ),

          // Star icon
          Positioned(
            left: _animationX1.value,
            top: _animationY1.value,
            child: _buildAnimatedIconStar(300.0),
          ),

          // Circle icon (using a circle shape)
          Positioned(
            left: _animationX2.value,
            top: _animationY2.value,
            child: _buildAnimatedCircle(300.0),
          ),

          // Square icon (using a square shape)
          Positioned(
            left: _animationX3.value,
            top: _animationY3.value,
            child: _buildAnimatedSquare(300.0),
          ),
        ],
      ),
    );
  }

  // Reusable function for building an animated icon with gradient
  Widget _buildAnimatedIconStar(double size) {
    List<Color> gradientColors = [
      const Color.fromARGB(255, 42, 9, 99).withOpacity(0.1),
      const Color.fromARGB(255, 109, 31, 122).withOpacity(0.1),
      const Color.fromARGB(255, 236, 191, 25).withOpacity(0.1),
    ];
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  // Reusable function for building an animated circle with gradient
  Widget _buildAnimatedCircle(double size) {
    List<Color> gradientColors = [
      const Color.fromARGB(255, 42, 9, 99).withOpacity(0.1).withOpacity(0.1),
      const Color.fromARGB(255, 109, 31, 122).withOpacity(0.1).withOpacity(0.1),
      const Color.fromARGB(235, 240, 190, 12).withOpacity(0.1).withOpacity(0.1),
    ];

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
    );
  }

  // Reusable function for building an animated square with gradient
  Widget _buildAnimatedSquare(double size) {
    List<Color> gradientColors = [
      const Color.fromARGB(255, 42, 9, 99).withOpacity(0.1),
      const Color.fromARGB(255, 109, 31, 122).withOpacity(0.1),
      const Color.fromARGB(255, 236, 191, 25).withOpacity(0.1),
    ];
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
    );
  }
}
