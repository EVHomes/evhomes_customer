
import 'package:ev_homes_customer/component/project_card.dart';
import 'package:ev_homes_customer/core/models/amenitiy_model.dart';
import 'package:ev_homes_customer/core/models/bhk_model.dart';
import 'package:ev_homes_customer/core/models/project_model.dart';
import 'package:ev_homes_customer/core/theme_colors.dart';
import 'package:flutter/material.dart';

const String name = 'Marina Bay';
const String description =
    "Marina Bay A EV Homes offers premium, NYC-inspired apartments with sleek, modern designs, panoramic city views, and luxurious amenities in a vibrant urban setting.";

final List<String> carouselImages = [
  "assets/images/Carousel-1.jpg",
  "assets/images/Carousel-2.jpg",
  "assets/images/Carousel-3.jpeg",
];
final List<String> bhk = [
  "All",
  "1RK",
  "1BHK",
  "2BHK",
  "3BHK",
  "4BHK",
  "Jodi",
];

String selectedConfiguration = 'All';
List<BhkModel> _bhkList = [
  BhkModel(
    reraId: "rera123",
    image: "assets/images/Floor1.jpg",
    carpetArea: "240 sq.ft",
    price: "20 lakhs",
    configuration: "1Rk",
  ),
  BhkModel(
    reraId: "rera-1bhk-23",
    image: "assets/images/Floor2.jpg",
    carpetArea: "360 sq.ft",
    price: "50 lakhs",
    configuration: "1BHK",
  ),
];
List<AmenitiyModel> _amenites = [
  AmenitiyModel(
    name: "Hall",
    image: "assets/images/hall.jpeg",
  ),
  AmenitiyModel(
    name: "Pool",
    image: "assets/images/pool.jpg",
  ),
  AmenitiyModel(
    name: "Gym",
    image: "assets/images/gym.jpeg",
  ),
];

final _pro = [ProjectModel(
  name: name,
  description: description,
  showCaseImage: carouselImages[0],
  carouselImages: carouselImages,
  bhkList: _bhkList,
  amenities: _amenites,
  locationLink: "https://maps.app.goo.gl/VywyURbZko3YtRqw7",
  locationName: "Vashi",
)];

class OurProjectsSection extends StatelessWidget {
  const OurProjectsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final settingProvider = Provider.of<SettingProvider>(context);
    // final List<ProjectModel> outprojects = settingProvider.ourProjects;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
        child: Text(
          'Our Projects',
          style: ThemeTexts.title3,
        ),
      ),
      const SizedBox(height: 10),
      SizedBox(
        height: 270,
        child: ListView.builder(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
          scrollDirection: Axis.horizontal,
          itemCount: _pro.length,
          itemBuilder: (context, index) {
            return ProjectCard(
              project: _pro[index],
              index: index, // Pass the index here
            );
          },
        ),
      ),
    ]);
  }
}
