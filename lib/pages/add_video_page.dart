import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ovrsr/utils/apptheme.dart';
import 'package:ovrsr/widgets/formatters/video_ID.dart';

import '../db_helpers/firebase/db_user_profile.dart';

class AddVideoPage extends StatefulWidget {
  const AddVideoPage({super.key});

  @override
  _AddVideoPageState createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Add New Video'),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/Logo_Light.png',
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SizedBox(
              width: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    cursorColor: AppTheme.light,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _title = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    cursorColor: AppTheme.light,
                    decoration: const InputDecoration(
                      labelText: 'YouTube Video URL',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a YouTube video URL';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      //_url = Text(extractVideoID(value!)) as String;
                      _url = extractVideoID(value!);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 128, 109, 0),
                          foregroundColor: AppTheme.light,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 128, 109, 0),
                          foregroundColor: AppTheme.light,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Call a function to save the video item to Firestore
                            _saveVideoItem();
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveVideoItem() async {
    bool success = await DBUserProfile.saveVideoItem(_title, _url);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video item saved successfully')),
      );
      // Optionally, you can navigate back to the previous screen
      Navigator.pop(context, _url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save video item')),
      );
    }
  }
}
