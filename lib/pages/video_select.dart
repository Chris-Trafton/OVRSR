import 'package:flutter/material.dart';
import 'package:ovrsr/widgets/main_drawer.dart';

class VideoSelectPage extends StatefulWidget {
  const VideoSelectPage({Key? key}) : super(key: key);

  @override
  State<VideoSelectPage> createState() => _VideoSelectPageState();
}

class _VideoSelectPageState extends State<VideoSelectPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Select'),
      ),
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Video ID',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Retrieve the video ID entered by the user
                String videoId = _controller.text.trim();
                // Pass the video ID back to the previous screen
                Navigator.pop(context, videoId);
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
