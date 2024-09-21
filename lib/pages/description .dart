import 'package:carousel_slider/carousel_slider.dart';
import 'package:ev_homes_customer/core/models/amenitiy_model.dart';
import 'package:ev_homes_customer/core/models/bhk_model.dart';
import 'package:ev_homes_customer/core/models/project_model.dart';
import 'package:ev_homes_customer/flutterflow/flutter_flow_theme.dart';
import 'package:ev_homes_customer/flutterflow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';


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

final _pro = ProjectModel(
  name: name,
  description: description,
  showCaseImage: carouselImages[0],
  carouselImages: carouselImages,
  bhkList: _bhkList,
  amenities: _amenites,
  locationLink: "https://maps.app.goo.gl/VywyURbZko3YtRqw7",
  locationName: "Vashi",
);

// final List<ConfigModel> imagesConfig = [
//   ConfigModel(
//       ConfigimageUrl: 'assets/images/Floor1.jpg',
//       reraid: 110310,
//       carpetarea: '240 sq.ft',
//       price: '20 Lakhs',
//       BhkAll: '1RK'),
//   ConfigModel(
//       ConfigimageUrl: 'assets/images/Floor2.jpg',
//       reraid: 110310,
//       carpetarea: '360 sq.ft',
//       price: '50 Lakhs',
//       BhkAll: '1BHK'),
//   ConfigModel(
//       ConfigimageUrl: 'assets/images/Floor3.jpg',
//       reraid: 110310,
//       carpetarea: '850 sq.ft',
//       price: '2.5 CR',
//       BhkAll: '2BHK'),
//   ConfigModel(
//       ConfigimageUrl: 'assets/images/Floor4.jpg',
//       reraid: 110311,
//       carpetarea: '1400 sq.ft',
//       price: '3.5 CR',
//       BhkAll: '3BHK'),
//   ConfigModel(
//       ConfigimageUrl: 'assets/images/Floor5.jpg',
//       reraid: 110311,
//       carpetarea: '1900 sq.ft',
//       price: '4.5 CR',
//       BhkAll: '4BHK'),
//   ConfigModel(
//       ConfigimageUrl: 'assets/images/Floor6.jpg',
//       reraid: 110311,
//       carpetarea: '2100 sq.ft',
//       price: '5 CR',
//       BhkAll: 'Jodi'),
// ];

// final List<ImageModel> imagesAme = [
//   ImageModel(
//       name: "9 Elements",
//       imageUrl: 'assets/images/hall.jpeg',
//       iconName: 'premium_24_filled'),
//   ImageModel(
//       name: "9 Infinity",
//       imageUrl: 'assets/images/pool.jpg',
//       iconName: 'swimming_pool_24_regular'),
//   ImageModel(
//       name: "9 Smash",
//       imageUrl: 'assets/images/Tennis Court-2.jpg',
//       iconName: 'sport_24_regular'),
//   ImageModel(
//       name: "Summit-9",
//       imageUrl: 'assets/images/gym2.jpeg',
//       iconName: 'dumbbell_24_regular'),
//   ImageModel(
//       name: "HUB-9",
//       imageUrl: 'assets/images/work from home office.png',
//       iconName: 'desktop_24_regular'),
//   // ImageModel(
//   //     name: "Flora 9",
//   //     imageUrl: 'assets/images/GardenView06.jpg',
//   //     iconName: 'sparkle_24_regular'),
//   ImageModel(
//       name: "Flora 9",
//       imageUrl: 'assets/images/GardenView07.jpg',
//       iconName: 'sparkle_24_regular'),
//   ImageModel(
//       name: "Track 9",
//       imageUrl: 'assets/images/Lobby.jpeg',
//       iconName: 'person_running_20_regular'),
//   ImageModel(
//       name: "9 Club",
//       imageUrl: 'assets/images/Carousel-3.jpeg',
//       iconName: 'building_24_regular'),
//   // ImageModel(
//   //     name: "9 Sky Divisible",
//   //     imageUrl: 'assets/images/Basketball.jpg',
//   //     iconName: 'sport_basketball_24_regular'),
//   ImageModel(
//       name: "9 Sky Divisible",
//       imageUrl: 'assets/images/Basketball-2.jpg',
//       iconName: 'sport_basketball_24_regular'),
//   ImageModel(
//       name: "9 Brahma",
//       imageUrl: 'assets/images/Meditation.jpg',
//       iconName: 'leaf_one_24_regular'),
// ];

// class ConfigModel {
//   final String ConfigimageUrl;
//   final int reraid;
//   final String carpetarea;
//   final String price;
//   final String BhkAll;

//   ConfigModel(
//       {required this.reraid,
//       required this.carpetarea,
//       required this.price,
//       required this.ConfigimageUrl,
//       required this.BhkAll});
// }

// class ImageModel {
//   final String iconName;
//   final String name;
//   final String imageUrl;

//   ImageModel(
//       {required this.name, required this.imageUrl, required this.iconName});
// }

// class FlipCardModel {
//   final String frontText;
//   final String imageUrl;

//   FlipCardModel({
//     required this.frontText,
//     required this.imageUrl,
//   });
// }

// final Map<String, IconData> fluentIconMap = {
//   'people_24_regular': FluentIcons.people_24_regular,
//   'swimming_pool_24_regular': FluentIcons.swimming_pool_24_regular,
//   'dumbbell_24_regular': FluentIcons.dumbbell_24_regular,
//   'leaf_one_24_regular': FluentIcons.leaf_one_24_regular,
//   'desktop_24_regular': FluentIcons.desktop_24_regular,
//   'sparkle_24_regular': FluentIcons.sparkle_24_regular,
//   'premium_24_filled': FluentIcons.premium_24_regular,
//   'sport_24_regular': FluentIcons.sport_24_regular,
//   'person_running_20_regular': FluentIcons.person_running_20_regular,
//   'building_24_regular': FluentIcons.building_24_regular,
//   'sport_basketball_24_regular': FluentIcons.sport_basketball_24_regular,
// };

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    final listt = selectedConfiguration == "All"
        ? _pro.bhkList
        : _pro.bhkList
            .where((config) => config.configuration == selectedConfiguration)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              MyCaraousel(imageUrls: carouselImages),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Text(
                      description,
                      style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 13,
                          color: Colors.black45),
                    ),
                  )
                ],
              ),
              AmenitiesSection(
                amenities: _pro.amenities,
              ),

              // Display the selected card
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: Text(
                      'Configuration',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ..._pro.bhkList.map(
                            (ele) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedConfiguration ==
                                        ele.configuration) {
                                      selectedConfiguration = "All";
                                    } else {
                                      selectedConfiguration = ele.configuration;
                                    }
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8.0),
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selectedConfiguration ==
                                            ele.configuration
                                        ? const Color.fromARGB(102, 97, 2, 231)
                                        : const Color.fromARGB(25, 98, 0, 234),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        FluentIcons
                                            .subtract_circle_arrow_back_16_filled,
                                        color: Colors.deepPurpleAccent,
                                        size: 16.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        ele.configuration,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 140,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: listt.length,
                        itemBuilder: (context, i) {
                          return Container(
                            width: 290,
                            height: 80,
                            margin: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 0.3,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    listt[i].image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('RERA ID: ${listt[i].reraId}'),
                                        const SizedBox(height: 4),
                                        Text(
                                            'Carpet Area: ${listt[i].carpetArea}'),
                                        const SizedBox(height: 4),
                                        Text('Price: ${listt[i].price}'),
                                        // const SizedBox(height: 4),
                                        Text(listt[i].configuration),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () => _downloadPdf(context),
                        text: 'Brochure',
                        icon: const Icon(
                          FluentIcons.arrow_download_24_regular,
                          size: 12,
                          color: Colors.deepPurpleAccent,
                        ),
                        options: FFButtonOptions(
                          height: 40,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 10, 10, 10),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Manrope',
                                    letterSpacing: 0.0,
                                    color: Colors.deepPurpleAccent,
                                  ),
                          elevation: 0.0,
                          borderSide: const BorderSide(
                            color: Colors.deepPurpleAccent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                        child: FFButtonWidget(
                      onPressed: () => _makePhoneCall(context),
                      text: 'Contact Us',
                      icon: const Icon(
                        FluentIcons.call_24_regular,
                        size: 12,
                        color: Colors.white,
                      ),
                      options: FFButtonOptions(
                        height: 40,
                        elevation: 0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10, 10, 10, 10),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: Colors.deepPurpleAccent,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Manrope',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 10,
            child: FloatingActionButton.small(
              mouseCursor: MouseCursor.defer,
              focusElevation: 4,
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurpleAccent,
              onPressed: () async {
                _openMap(_pro.locationLink);
              },
              child: const Icon(
                FluentIcons.compass_northwest_20_regular,
                size: 20,
              ),
            ),
          ),
          Positioned(
            bottom: 110,
            right: 10,
            child: FloatingActionButton.small(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurpleAccent,
              onPressed: () {
                _showShareDialog(context);
              },
              child: const Icon(FluentIcons.share_20_regular, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _openMap(String locationUrl) async {
    if (await canLaunchUrl(Uri.parse(locationUrl))) {
      await launchUrl(Uri.parse(locationUrl));
    } else {
      print("cant open map");
      throw 'Could not open the map.';
    }
  }
}

Future<void> _downloadPdf(BuildContext context) async {
  try {
    // Load the PDF from assets
    final ByteData data = await rootBundle.load('assets/Layout.pdf');
    final List<int> bytes = data.buffer.asUint8List();

    // Get the directory for storing the PDF
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory!.path}/Layout.pdf';

    // Write the PDF to the file
    final File file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);

    // Show a snackbar with the file path
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF downloaded to $filePath')),
    );

    // Open the downloaded PDF
    await OpenFile.open(filePath);
  } catch (e) {
    // Handle any errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to download PDF: $e')),
    );
  }
}

Future<void> _makePhoneCall(BuildContext context) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: '8766037284',
  );
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not launch phone dialer')),
    );
  }
}

const String appLink =
    'https://play.google.com/store/apps/details?id=com.instagram.android&pcampaignid=web_share';

Future<void> _shareViaWhatsApp(BuildContext context) async {
  final Uri whatsappUri =
      Uri.parse("whatsapp://send?text=Check out this app: $appLink");

  if (await canLaunchUrl(whatsappUri)) {
    await launchUrl(whatsappUri);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("WhatsApp is not installed on this device")),
    );
  }
}

void _showShareDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Share App"),
        content: const Text(
            "Do you want to share this app with your friends via WhatsApp?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _shareViaWhatsApp(context); // Proceed to share
            },
            child: const Text("Share"),
          ),
        ],
      );
    },
  );
}

class MyCaraousel extends StatefulWidget {
  final List<String> imageUrls;

  const MyCaraousel({
    super.key,
    required this.imageUrls,
  });

  @override
  State<MyCaraousel> createState() => _MyCaraouselState();
}

class _MyCaraouselState extends State<MyCaraousel> {
  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselSliderController,
          itemCount: carouselImages.length,
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                carouselImages[index],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          },
          options: CarouselOptions(
            height: 350,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imageUrls.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _carouselSliderController.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class AmenitiesSection extends StatefulWidget {
  final List<AmenitiyModel> amenities;
  const AmenitiesSection({
    super.key,
    required this.amenities,
  });

  @override
  State<AmenitiesSection> createState() => _AmenitiesSectionState();
}

class _AmenitiesSectionState extends State<AmenitiesSection> {
  // Pass the amenities list
  String selectedAme = "All";

  @override
  Widget build(BuildContext context) {
    final uniqueAmenities = widget.amenities.toSet().toList();
    final seenNames = <String>{};

    final filteredAmenities = uniqueAmenities.where((amenity) {
      if (seenNames.contains(amenity.name)) {
        return false;
      } else {
        seenNames.add(amenity.name);
        return true;
      }
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
          child: Text(
            'Amenities',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle tap event here
                    setState(() {
                      selectedAme = "All";
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(25, 98, 0, 234),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          // fluentIconMap[widget.amenities[index].iconName] ??
                          FluentIcons.question_circle_24_regular,
                          color: Colors.deepPurpleAccent,
                          size: 16.0,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          "All",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                ...List.generate(filteredAmenities.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle tap event here
                      setState(() {
                        if (filteredAmenities[index].name == selectedAme) {
                          selectedAme = "All";
                        } else {
                          selectedAme = filteredAmenities[index].name;
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(25, 98, 0, 234),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            // fluentIconMap[widget.amenities[index].iconName] ??
                            FluentIcons.question_circle_24_regular,
                            color: Colors.deepPurpleAccent,
                            size: 16.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            uniqueAmenities[index].name,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        HorizontalStaggeredGallery(
          selectedAme: selectedAme,
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class HorizontalStaggeredGallery extends StatelessWidget {
  final String? selectedAme;
  const HorizontalStaggeredGallery({super.key, this.selectedAme});

  @override
  Widget build(BuildContext context) {
    List<AmenitiyModel> newImages = selectedAme != "All"
        ? _pro.amenities.where((ele) => ele.name == selectedAme).toList()
        : _pro.amenities;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 300,
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          children: List.generate(newImages.length, (index) {
            return StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: Card.filled(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    newImages[index].image,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
