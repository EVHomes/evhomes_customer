
import 'package:ev_homes_customer/component/lottiepage.dart';
import 'package:ev_homes_customer/core/models/bhk_model.dart';
import 'package:ev_homes_customer/core/models/project_model.dart';
import 'package:ev_homes_customer/pages/AnimatedGradientScreen.dart';
import 'package:ev_homes_customer/pages/description_screen.dart';
// import 'package:ev_homes_customer/pages/description%20.dart';
import 'package:ev_homes_customer/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurProjectList extends StatelessWidget {
  const OurProjectList({super.key});

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingsProvider>(context);
    final List<ProjectModel> outprojects = settingProvider.ourProjects;

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: outprojects.length,
        itemBuilder: (context, index) {
          return PropertyCard(project: outprojects[index]);
        },
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final ProjectModel project;

  const PropertyCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Lottiepage(),
          ),
        );

        await Future.delayed(const Duration(seconds: 2));

        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => DescriptionScreen(project: project),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 180,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedGradient(),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: const Color.fromARGB(255, 26, 25, 25)
                  //         .withOpacity(0.6),
                  //     offset: Offset(0, 6),
                  //     blurRadius: 2,
                  //     spreadRadius: 1,
                  //   )
                  // ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Image.network(
                                  project.showCaseImage,
                                  width: 250,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: 250,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(
                                                  255, 26, 25, 25)
                                              .withOpacity(0.6),
                                          offset: const Offset(0, 6),
                                          blurRadius: 7,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(project.locationName,
                                  style: const TextStyle(color: Colors.white)),
                              const SizedBox(
                                width: 20,
                              ),
                              const Icon(
                                Icons.house,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                _buildBhkText(project.bhkList),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
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

  String _buildBhkText(List<BhkModel> bhkList) {
    return bhkList.isNotEmpty
        ? bhkList.map((bhk) => bhk.configuration).join(', ')
        : 'No BHK available';
  }
}
