import 'package:ev_homes_customer/Wrappers/home_wrapper.dart';
import 'package:ev_homes_customer/pages/meeting_summary_page.dart';
import 'package:flutter/material.dart';

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

  MyMeetings({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to HomeWrapper when back button is pressed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeWrapper()),
        );
        return false; // Prevent default back action
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // Navigate back to the home screen or previous screen
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
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: completedMeetings.length,
                itemBuilder: (context, index) {
                  final meeting = completedMeetings[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the summary page when a meeting is tapped
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
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text(
                            meeting['title']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(meeting['description']!),
                              const SizedBox(height: 4),
                              Text('Meeting time: ${meeting['time']}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
