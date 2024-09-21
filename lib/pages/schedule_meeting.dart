import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class ScheduleMeetingPage extends StatefulWidget {
  const ScheduleMeetingPage({super.key});

  @override
  _ScheduleMeetingPageState createState() => _ScheduleMeetingPageState();
}

class _ScheduleMeetingPageState extends State<ScheduleMeetingPage> {
  TextEditingController dateTimeController = TextEditingController();
  String? selectedPlace;

  @override
  void dispose() {
    dateTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          dateTimeController.text =
              "${"${selectedDateTime.toLocal()}".split(' ')[0]} ${pickedTime.format(context)}";
        });
      }
    }
  }

  Future<void> _launchGoogleMaps(String place) async {
    if (place.isNotEmpty) {
      Uri.encodeComponent(place);
      const String url = 'https://maps.app.goo.gl/VywyURbZko3YtRqw7';
      try {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          throw 'Could not launch $url';
        }
      } catch (e) {
        print('Error launching URL: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error opening Google Maps')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> places = [
      'Plot Number 16, Juhu Nagar, Sector 9, Vashi, Navi Mumbai, Maharashtra 400703',
      'VS2-24, Ganesh Marg, Juhu Nagar, Juhu Village, Sector 10, Vashi, Navi Mumbai, Maharashtra 400703',
      '212, Vardhaman Chambers, Vashi Flyover, Sector 17, Vashi, Navi Mumbai, Maharashtra 400703'
    ];

    final List<String> purpose = [
      'Pricing',
      'Booking',
      'Negotiation',
      'Payment'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule a Meeting'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date and Time field
              TextField(
                controller: dateTimeController,
                decoration: const InputDecoration(
                  labelText: 'Date & Time',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: _selectDateTime,
              ),
              const SizedBox(height: 16),

              // Place field
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Place',
                  suffixIcon: Icon(Icons.add_location),
                  border: OutlineInputBorder(),
                ),
                items: places.map((String place) {
                  return DropdownMenuItem<String>(
                    value: place,
                    child: Text(place),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPlace = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Purpose field
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Purpose',
                  border: OutlineInputBorder(),
                ),
                items: purpose.map((String purpose) {
                  return DropdownMenuItem<String>(
                    value: purpose,
                    child: Text(purpose),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
              ),
              const SizedBox(height: 25),

              // Schedule button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _launchGoogleMaps(
                        " "); // Open Google Maps when button pressed
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Request has been sent')),
                    );
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 30, 155, 78),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text('Send Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
