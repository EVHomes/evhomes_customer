import 'package:carousel_slider/carousel_slider.dart';
import 'package:ev_homes_customer/component/custom_pdf_viewer.dart';
import 'package:ev_homes_customer/core/constant.dart';
import 'package:ev_homes_customer/core/models/amenitiy_model.dart';
import 'package:ev_homes_customer/core/models/project_model.dart';
import 'package:ev_homes_customer/flutterflow/flutter_flow_theme.dart';
import 'package:ev_homes_customer/flutterflow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';


final Map<String, IconData> fluentIconMap = {
  'people_24_regular': FluentIcons.people_24_regular,
  'swimming_pool_24_regular': FluentIcons.swimming_pool_24_regular,
  'dumbbell_24_regular': FluentIcons.dumbbell_24_regular,
  'leaf_one_24_regular': FluentIcons.leaf_one_24_regular,
  'desktop_24_regular': FluentIcons.desktop_24_regular,
  'sparkle_24_regular': FluentIcons.sparkle_24_regular,
  'premium_24_filled': FluentIcons.premium_24_regular,
  'sport_24_regular': FluentIcons.sport_24_regular,
  'person_running_20_regular': FluentIcons.person_running_20_regular,
  'building_24_regular': FluentIcons.building_24_regular,
  'sport_basketball_24_regular': FluentIcons.sport_basketball_24_regular,
};
IconData getIconData(String name) {
  IconData icon = FluentIcons.people_24_regular;

  if (name.toLowerCase().contains("swim") ||
      name.toLowerCase().contains("pool")) {
    icon = FluentIcons.swimming_pool_24_regular;
  } else if (name.toLowerCase().contains("gym") ||
      name.toLowerCase().contains("summit")) {
    icon = FluentIcons.dumbbell_24_regular;
  } else if (name.toLowerCase().contains("hall") ||
      name.toLowerCase().contains("banquet") ||
      name.toLowerCase().contains("banquet")) {
    icon = FluentIcons.sparkle_24_regular;
  } else if (name.toLowerCase().contains("sport") ||
      name.toLowerCase().contains("garden") ||
      name.toLowerCase().contains("ball")) {
    icon = FluentIcons.sport_24_regular;
  }

  return icon;
}

class DescriptionScreen extends StatefulWidget {
  final ProjectModel project;
  const DescriptionScreen({super.key, required this.project});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  String selectedConfiguration = 'All';

  @override
  Widget build(BuildContext context) {
    final listt = selectedConfiguration == "All"
        ? widget.project.bhkList
        : widget.project.bhkList
            .where((config) => config.configuration == selectedConfiguration)
            .toList();

    return Scaffold(
      backgroundColor: Constant.bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.project.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Constant.bgColor,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              MyCaraousel(imageUrls: widget.project.carouselImages),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Text(
                      widget.project.description,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              AmenitiesSection(
                amenities: widget.project.amenities,
              ),

              // Display the selected card
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: Text(
                      'Configuration',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
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
                          ...widget.project.bhkList.map(
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
                                      color: Constant.bgColor,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          blurRadius: 2,
                                          spreadRadius: 1,
                                        )
                                      ]),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        FluentIcons
                                            .subtract_circle_arrow_back_16_filled,
                                        color: Colors.white,
                                        size: 16.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        ele.configuration,
                                        style: const TextStyle(
                                          color: Colors.white,
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
                                color: Constant.bgColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                  )
                                ]),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Show dialog with the large image
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            child: Image.network(
                                              listt[i].image,
                                              width: double.infinity,
                                              height: 250,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Image.network(
                                      listt[i].image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'RERA ID: ${listt[i].reraId}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Carpet Area: ${listt[i].carpetArea}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Price: ${listt[i].price}',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        // const SizedBox(height: 4),
                                        Text(
                                          listt[i].configuration,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
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
              color: Constant.bgColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
  Expanded(
    child: FFButtonWidget(
      onPressed: () {
        if (widget.project.brochure?.isEmpty ?? true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No Brochure available at the moment.'),
            ),
                            );
                            return;
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CustomPdfViewer(
                                  link: "widget.project.brochure"),
                            ),
                          );
                        },
                        text: 'Brochure',
                        icon: Icon(
                          FluentIcons.arrow_download_24_regular,
                          size: 12,
                          color: Constant.bgColor,
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
                                    color: Constant.bgColor,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Constant.bgColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Constant.bgColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 2,
                              spreadRadius: 1,
                            )
                          ]),
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
                          color: Colors.transparent,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Manrope',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Constant.bgColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 2,
                      spreadRadius: 1,
                    )
                  ]),
              child: FloatingActionButton.small(
                mouseCursor: MouseCursor.defer,
                focusElevation: 4,
                foregroundColor: Colors.white,
                backgroundColor: Constant.bgColor,
                onPressed: () async {
                  _openMap(widget.project.locationLink);
                },
                child: const Icon(
                  FluentIcons.compass_northwest_20_regular,
                  size: 20,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 130,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Constant.bgColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 2,
                      spreadRadius: 1,
                    )
                  ]),
              child: FloatingActionButton.small(
                foregroundColor: Colors.white,
                backgroundColor: Constant.bgColor,
                onPressed: () {
                  _showShareDialog(context);
                },
                child: const Icon(FluentIcons.share_20_regular, size: 20),
              ),
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

Future<void> _makePhoneCall(BuildContext context) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: '554545487',
  );

  try {
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch phone dialer';
    }
  } catch (e) {
    print(e);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not launch phone dialer')),
    );
  }
}

Future<void> _shareViaWhatsApp(BuildContext context) async {
  const String appLink =
      'https://evgroup.in/ev-marina-bay-apartments-mumbai.html';

  // final Uri whatsappUri =
  //     Uri.parse("whatsapp://send?text=Check out this app: $appLink");
  final Uri whatsappUri = Uri.parse(appLink);

  if (await canLaunchUrl(whatsappUri)) {
    await launchUrl(whatsappUri);
  } else {
    if (!context.mounted) return;

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
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.imageUrls[index],
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
                          : Colors.white)
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
              color: Colors.white,
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
                        color: Constant.bgColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 2,
                            spreadRadius: 1,
                          )
                        ]),
                    child: const Row(
                      children: [
                        Icon(
                          FluentIcons.people_24_regular,
                          color: Colors.white,
                          size: 16.0,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          "All",
                          style: TextStyle(color: Colors.white),
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
                          color: Constant.bgColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 2,
                              spreadRadius: 1,
                            )
                          ]),
                      child: Row(
                        children: [
                          Icon(
                            // fluentIconMap[widget.amenities[index].iconName] ??
                            getIconData(filteredAmenities[index].name),
                            // FluentIcons.question_circle_24_regular,
                            color: Colors.white,
                            size: 16.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            uniqueAmenities[index].name,
                            style: const TextStyle(color: Colors.white),
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
          selectedAmenity: selectedAme,
          amenities: widget.amenities,
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class HorizontalStaggeredGallery extends StatelessWidget {
  final List<AmenitiyModel> amenities;
  final String selectedAmenity;

  const HorizontalStaggeredGallery({
    super.key,
    required this.amenities,
    required this.selectedAmenity,
  });

  @override
  Widget build(BuildContext context) {
    List<AmenitiyModel> newImages = selectedAmenity != "All"
        ? amenities.where((ele) => ele.name == selectedAmenity).toList()
        : amenities;
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
              child: GestureDetector(
                onTap: () {
                  // Show dialog with the large image
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              16), // Adjust the radius here
                          child: Image.network(
                            newImages[index].image,
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Card.filled(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(8), // Small radius for gallery
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            8), // Same radius for consistency
                      ),
                      child: Image.network(
                        newImages[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
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
