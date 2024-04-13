import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ovrsr/pages/add_video_page.dart';
import 'package:ovrsr/utils/apptheme.dart';
import 'package:ovrsr/widgets/main_drawer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../db_helpers/firebase/firestore_keys.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Set the default video ID
    _setDefaultVideoId();
  }

  // Sets the default video ID to the top of the list
  Future<void> _setDefaultVideoId() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(FS_COL_SA_USER_PROFILES)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('video_items')
        .orderBy('date', descending: true) // Order by date in descending order
        .limit(1) // Limit to the first document
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final topVideoUrl = querySnapshot.docs.first['url'];
      setState(() {
        _videoId = topVideoUrl;
      });
    }
  }

  String? _videoId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Home'),
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
      drawer: const FractionallySizedBox(
        widthFactor: 0.18, // 20% of the screen width
        child: MainDrawer(),
      ),
      body: Expanded(
        child: SizedBox(
          height: 1000,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        // Width should be 15% of the screen width
                        width: constraints.maxWidth * 0.15,
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(0, 128, 109, 0),
                            foregroundColor: AppTheme.light,
                          ),
                          onPressed: () async {
                            // Navigate to AddVideoPage and await result
                            final result =
                                await Navigator.of(context).push<String>(
                              MaterialPageRoute(
                                builder: (context) => const AddVideoPage(),
                              ),
                            );
                            // Update _videoId with the returned video ID
                            if (result != null) {
                              setState(() {
                                _videoId = result;
                              });
                            }
                          },
                          child: const Text('New Stream'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Your Streams',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Display a list of video items from Firestore
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(FS_COL_SA_USER_PROFILES)
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('video_items')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final documents = snapshot.data!.docs;
                          if (documents.isEmpty) {
                            return const Center(child: Text('No videos found'));
                          }
                          return SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height - 150,
                              width: 250,
                              child: ListView.builder(
                                itemCount: documents.length,
                                itemBuilder: (context, index) {
                                  final title = documents[index]['title'];
                                  final date =
                                      documents[index]['date']; // Retrieve date
                                  final url =
                                      documents[index]['url']; // Retrieve URL
                                  return Dismissible(
                                    key: Key(documents[index].id),
                                    onDismissed: (direction) async {
                                      // Delete item from Firestore
                                      await FirebaseFirestore.instance
                                          .collection(FS_COL_SA_USER_PROFILES)
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection('video_items')
                                          .doc(documents[index].id)
                                          .delete();
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _videoId =
                                              url; // Update _videoId with the URL
                                        });
                                      },
                                      child: ListTile(
                                        hoverColor: AppTheme.accent,
                                        title: Text(title),
                                        subtitle: Text(
                                            date.toString()), // Display date
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const VerticalDivider(),
                  SizedBox(
                      // Width should be 80% of the screen width
                      width: constraints.maxWidth * 0.8,
                      child: PlayerWidget(videoId: _videoId)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final String? videoId; // Receive videoId as a parameter

  const PlayerWidget({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (videoId == null) {
      return YoutubePlayer(
        key: UniqueKey(), // Add a UniqueKey here
        controller: YoutubePlayerController.fromVideoId(
          videoId: '',
          params: const YoutubePlayerParams(
            showControls: true,
            showFullscreenButton: true,
          ),
        ),
        aspectRatio: 16 / 9,
      );
    }
    return YoutubePlayer(
      key: UniqueKey(), // Add a UniqueKey here
      controller: YoutubePlayerController.fromVideoId(
        videoId: videoId!,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      ),
      aspectRatio: 16 / 9,
    );
  }
}
