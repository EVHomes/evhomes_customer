import 'package:flutter/material.dart';

class SpecialOfferPopup extends StatelessWidget {
  const SpecialOfferPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
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
              const SizedBox(height: 10),
              // Special Offer Title
              const Text(
                '🏡 Special Holiday Offer! 🎉',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              // Image Placeholder
              Image.asset(
                'assets/images/hotair balloon.jpg', // Replace with your image
                height: 100,
              ),
              const SizedBox(height: 10),
              // Offer Description
              const Text(
                'Get a 15,000 discount on your first home purchase!\n'
                'Limited time offer - Don\'t miss out!\n'
                'Contact us today to schedule a viewing!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              // Additional Text
              const Text(
                'Why wait? Your dream home awaits! Explore our listings now.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Show the SpecialOfferPopup without any animation
            var context;
            showDialog(
              context: context, 
              builder: (context) => const SpecialOfferPopup(),
            );
          },
          child: const Text('Show Special Offer'),
        ),
      ),
    ),
  ));
}
