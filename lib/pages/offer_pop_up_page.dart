import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class CelebratePopup extends StatefulWidget {
  const CelebratePopup({super.key});

  @override
  _CelebratePopupState createState() => _CelebratePopupState();
}

class _CelebratePopupState extends State<CelebratePopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _santaSlideAnimation;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    // Santa slide animation
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _santaSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from below the screen
      end: const Offset(0, 0), // Slide to original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward(); // Start the animation

    // Confetti controller for the birthday bash effect
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    _confettiController.play(); // Automatically start confetti
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7), // Background overlay
      body: Stack(
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Close Button
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Title
                      const Text(
                        'Celebrate',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'The Season With Us!',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Santa & Trees (using a SlideTransition for animation)
                      SlideTransition(
                        position: _santaSlideAnimation,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/santa.jpg', // Replace with your Santa asset
                              height: 150,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Why wait until December 25th? The first time, the first sale with fast delivery! Christmas is a time for giving.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                // Confetti overlay for birthday bash effect
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirection: -3.14 / 2, // Upwards
                    shouldLoop: true, // Continue confetti animation
                    colors: const [
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ], // Custom colors
                    numberOfParticles: 20, // Number of confetti pieces
                    gravity: 0.1, // Speed of falling confetti
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
