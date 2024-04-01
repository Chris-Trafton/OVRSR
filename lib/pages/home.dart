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
  String? _videoId; // Default video ID = 'vFJ8cWhbTGA'

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
      drawer: const MainDrawer(),
      body: Expanded(
        child: SizedBox(
          height: 1000,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return Column(
                  children: [
                    PlayerWidget(
                        videoId: _videoId), // Pass videoId to PlayerWidget
                    const Divider(),
                    Row(
                      children: [
                        ElevatedButton(
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
                          child: const Text('Video Select'),
                        ),
                        // TODO: To the right of the button, display a list of video items from Firestore
                      ],
                    ),
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 250,
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
                            child: const Text('New Video'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Your Videos',
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
                              return const Center(
                                  child: Text('No videos found'));
                            }
                            return SingleChildScrollView(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 150,
                                width: 250,
                                child: ListView.builder(
                                  itemCount: documents.length,
                                  itemBuilder: (context, index) {
                                    final title = documents[index]['title'];
                                    final url = documents[index]['url'];
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          _videoId = url;
                                        });
                                      },
                                      child: ListTile(
                                        hoverColor: AppTheme
                                            .accent, // Not working as intended
                                        title: Text(title),
                                        subtitle: Text(url),
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
                    Expanded(child: PlayerWidget(videoId: _videoId)),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final String? videoId; // Receive videoId as a parameter

  const PlayerWidget({Key? key, this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (videoId == null) {
      return YoutubePlayer(
        key: UniqueKey(), // Add a UniqueKey here
        controller: YoutubePlayerController.fromVideoId(
          videoId: 'B4-L2nfGcuE',
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
