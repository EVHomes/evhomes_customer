import 'package:ev_homes_customer/pages/login_page.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    const OnboardingPage(
      imagePath: 'assets/images/evicon.png',
      title: 'Welcome to EV Homes! \nE V Group is one of the leading and fast-growing Real Estate Companies in India.',
      height: 150.0,
    ),
    const OnboardingPage(
      imagePath: 'assets/images/image1.png',
      title: "Discover luxury homes designed by our expert engineers, ensuring quality and innovation in every detail.",
      height: 250.0,
    ),
    const OnboardingPage(
      imagePath: 'assets/images/image2.png',
      title: 'At EV Homes, we believe in transparency. \nFrom the first consultation to your new front door, we’re here to guide you every step of the way.',
      showButton: true,
      height: 200.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: _pages,
          ),
          Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    return List<Widget>.generate(_pages.length, (i) {
      return _indicator(i == _currentPage);
    });
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool showButton;
  final double? height;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    this.showButton = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(255, 236, 230, 1), // Background color
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height ?? 200.0,
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40.0),
          if (showButton)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () {
                 Navigator.pushReplacement(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(), // Replace with your destination page
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Slide in from right
      const end = Offset.zero; // Ends in the center
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 650), // Duration of the transition
  ),
);

                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  minimumSize: const Size(100, 40),
                ),
                child: const Text('Get Started', style: TextStyle(fontSize: 16.0)),
              ),
            ),
        ],
      ),
    );
  }
}