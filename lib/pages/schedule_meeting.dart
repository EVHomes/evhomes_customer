// import 'package:ev_homes_customer/provider/dataprovider.dart';
import 'package:ev_homes_customer/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ev_homes_customer/core/models/meeting_model.dart';

class ScheduleMeeting extends StatefulWidget {
  const ScheduleMeeting({super.key});

  @override
  _ScheduleMeetingState createState() => _ScheduleMeetingState();
}

class _ScheduleMeetingState extends State<ScheduleMeeting> {
  DateTime? selectedDateTime;
  String? selectedPlace;
  String? selectedPurpose;
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> storeMeetingData() async {
    if (selectedDateTime == null ||
        selectedPlace == null ||
        selectedPurpose == null) {
      return;
    }

    final newMeeting = MeetingModel(
      date:
          '${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year} ${selectedDateTime!.hour}:${selectedDateTime!.minute}',
      place: selectedPlace!,
      purpose: selectedPurpose!,
    );

    try {
      await FirebaseFirestore.instance
          .collection('meetings')
          .add(newMeeting.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Meeting request sent successfully!')),
      );
      //  _firestoreMeeting.storeMeetingData("");
      _resetForm();
    } catch (e) {
      print('Error storing meeting data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to send meeting request. Please try again.')),
      );
    }
  }

  void _resetForm() {
    setState(() {
      selectedDateTime = null;
      selectedPlace = null;
      selectedPurpose = null;
      _dateController.clear();
    });
  }

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _dateController.text =
              '${pickedDate.day}/${pickedDate.month}/${pickedDate.year} ${pickedTime.hour}:${pickedTime.minute}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final places = settingsProvider.places;
    final purposes = settingsProvider.purposes;
    // final meetings =_firestoreMeeting.storeMeetingData(meeting);
    final placeUrls = settingsProvider.placeUrls;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Meeting'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        labelText: 'Select Date & Time',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () => _selectDateTime(context),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a date and time';
                        }
                        return null;
                      },
                      readOnly: true,
                    ),
                    const SizedBox(height: 24),
                    DropdownButtonFormField<String>(
                      value: selectedPlace,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPlace = newValue;
                        });
                      },
                      items:
                          places.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        labelText: 'Select Place',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a place';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    DropdownButtonFormField<String>(
                      value: selectedPurpose,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPurpose = newValue;
                        });
                      },
                      items: purposes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        labelText: 'Purpose',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.note),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a purpose';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              storeMeetingData();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                          ),
                          child: const Text('Send Request'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: selectedPlace == null
                              ? null
                              : () {
                                  _launchURL(placeUrls[selectedPlace]!);
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blueAccent,
                            elevation: 2,
                          ),
                          child: const Text('Go To Location'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // const Text(
              //   'Scheduled Meetings',
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 16),
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: meetings.length,
              //   itemBuilder: (context, index) {
              //     final meeting = meetings[];
              //     return Card(
              //       margin: const EdgeInsets.only(bottom: 16),
              //       child: ListTile(
              //         title: Text('Date: ${meeting.date}'),
              //         subtitle: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text('Place: ${meeting.place}'),
              //             Text('Purpose: ${meeting.purpose}'),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
