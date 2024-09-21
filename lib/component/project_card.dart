
import 'package:ev_homes_customer/core/models/project_model.dart';
import 'package:ev_homes_customer/pages/description%20.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final int index;

  const ProjectCard({
    required this.project,
    required this.index, // Add this line to accept index
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Define the list of gradients
    final List<LinearGradient> gradients = [
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.deepPurpleAccent.withOpacity(0.0),
          Colors.deepPurpleAccent.withOpacity(0.3),
        ],
      ),
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.pinkAccent.withOpacity(0.0),
          Colors.pinkAccent.withOpacity(0.3),
        ],
      ),
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.deepOrangeAccent.withOpacity(0.0),
          Colors.deepOrangeAccent.withOpacity(0.3),
        ],
      ),
    ];

    // Determine the gradient based on the index
    final gradient = gradients[index % gradients.length];

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DescriptionScreen(),
            ),
          );
        },
        child: Container(
          width: 180,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(project.showCaseImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Translucent Overlay with Gradient
              Container(
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              // Text on top of the overlay
              Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      project.locationName,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
