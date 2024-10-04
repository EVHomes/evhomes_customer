import 'package:ev_homes_customer/pages/AnimatedGradientScreen.dart';
import 'package:flutter/material.dart';

class MeetingSummaryPage extends StatelessWidget {
  final String title;
  final String description;
  final String date;

  const MeetingSummaryPage({
    super.key,
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Summary'),
        backgroundColor: Colors.transparent,
        elevation: 0, // Transparent app bar to allow the gradient to show
      ),
      body: Stack(
        children: [
             AnimatedGradient(),
          // Foreground content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ensure visibility over gradient
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70, // Ensure visibility over gradient
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Completed on: $date',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white54, // Ensure visibility over gradient
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
