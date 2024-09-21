import 'package:ev_homes_customer/component/custom_appbar.dart';
import 'package:ev_homes_customer/component/video_player.dart';
import 'package:ev_homes_customer/pages/profile_screen.dart';
import 'package:ev_homes_customer/section/our_project_section.dart';
import 'package:ev_homes_customer/section/whats_new_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const OfferSection(),
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.7,
            maxChildSize: 1,
            builder: (BuildContext context, ScrollController scrollController) {
              return MainSection(scrollController: scrollController);
            },
          ),
        ],
      ),
    );
  }
}

// Section Widget
class OfferSection extends StatelessWidget {
  const OfferSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      width: 600,
      // child: Lottie.asset('assets/animations/offers_1_1.json'),
      child: VideoPlayerWidget(
        videoPath:
            'https://firebasestorage.googleapis.com/v0/b/ev-homes-main-app.appspot.com/o/assets%2Foffers.mp4?alt=media&token=dcd34da1-2b5e-444c-8dc8-5afa591d5907',
      ),
    );
  }
}

class MainSection extends StatelessWidget {
  final ScrollController scrollController;

  const MainSection({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    // final settingProvider = Provider.of<SettingProvider>(context);
    // final List<ProjectModel> outprojects = settingProvider.ourProjects;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        children: [
          // Text("${outprojects.length}"),
          CustomAppBar(
            onSearchPressed: () {},
            onProfilePressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: const Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // EMICalculatorScreen(),
                    SizedBox(height: 20),
                    OurProjectsSection(),
                    SizedBox(height: 20),
                    WhatsNewSection(),
                    SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
