import 'package:flutter/material.dart';
import 'package:ev_homes_customer/Wrappers/home_wrapper.dart';
import 'package:ev_homes_customer/pages/AnimatedGradientScreen.dart';
import 'package:ev_homes_customer/pages/meeting_summary_page.dart';

class MyMeetings extends StatelessWidget {
  final List<Map<String, String>> completedMeetings = [
    {
      'title': 'Booking',
      'description': 'Discuss about flat booking',
      'time': '10:00 AM - 12:00 PM',
    },
    {
      'title': 'Registration',
      'description': 'Registration of flat.',
      'time': '9:00 AM - 12:00 PM',
    },
  ];

  MyMeetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeWrapper()),
        );
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeWrapper()),
              );
            },
          ),
          title: const Text(
            'My Meetings',
            style: TextStyle(
              fontFamily: 'sans serif',
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: AnimatedGradient(),
            ),
            SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final meeting = completedMeetings[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MeetingSummaryPage(
                                      title: meeting['title']!,
                                      description: meeting['description']!,
                                      date: meeting['time']!,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                 color: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
            
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  title: Text(
                                    meeting['title']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xFF2e2252),
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      Text(
                                        meeting['description']!,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Meeting time: ${meeting['time']}',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: completedMeetings.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}