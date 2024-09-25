import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening URLs

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

  final places = {
    'Nine Square Office': 'https://maps.app.goo.gl/T7q46CqTnUFwSHc28',
    'Head Office': 'https://maps.app.goo.gl/bkMsGhfcYfcdk3Cm9'
  };

  final purposes = ['Pricing', 'Booking', 'Negotiation', 'Payment'];

  // Function to launch URL using Uri
  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication); // Use external application mode for Google Maps
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to select both date and time
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
          _dateController.text = '${pickedDate.day}/${pickedDate.month}/${pickedDate.year} ${pickedTime.hour}:${pickedTime.minute}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Meeting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Date & Time Picker
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

              // Place Dropdown
              DropdownButtonFormField<String>(
                value: selectedPlace,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPlace = newValue;
                  });
                },
                items: places.keys.map<DropdownMenuItem<String>>((String value) {
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

              // Purpose Dropdown
              DropdownButtonFormField<String>(
                value: selectedPurpose,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPurpose = newValue;
                  });
                },
                items: purposes.map<DropdownMenuItem<String>>((String value) {
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

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Request Sent'),
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                    ),
                    child: Text('Send Request'),
                  ),
                  const SizedBox (width: 16),
                  ElevatedButton(
                    onPressed: selectedPlace == null
                        ? null
                        : () {
                            _launchURL (places[selectedPlace]!);
                          },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ), backgroundColor: Colors.blueAccent,
                      elevation: 2,
                    ),
                    child: Text('Go To Location'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}