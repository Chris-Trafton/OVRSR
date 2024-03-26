import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:ovrsr/models/video_item.dart';
import 'package:ovrsr/utils/apptheme.dart';
import 'package:ovrsr/widgets/main_drawer.dart';

import 'package:http/http.dart' as http;

class NewVideoItem extends StatefulWidget {
  const NewVideoItem({super.key});

  @override
  State<StatefulWidget> createState() => _NewVideoItemState();
}

class _NewVideoItemState extends State<NewVideoItem> {
  final _formKey = GlobalKey<FormState>();
  var _isSending = false;
  var _enteredTitle = '';
  var _enteredVideoUrl = '';

  void _saveVideo() async {
    if (!_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https('');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': _enteredTitle,
          'videoUrl': _enteredVideoUrl,
        }),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(VideoItem(
          title: responseData['title'], videoUrl: responseData['videoUrl']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Video'),
      ),
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredTitle = value!;
                  },
                ),
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: 'Enter Video URL',
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // @TODO: Pull Video ID from URL
                    _enteredVideoUrl = value!;
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(0, 128, 109, 0),
                foregroundColor: AppTheme.light,
              ),
              onPressed: _isSending
                  ? null
                  : () {
                      _saveVideo();
                    },
              child: _isSending
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(),
                    )
                  : const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
