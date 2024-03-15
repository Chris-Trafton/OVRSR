import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ovrsr/utils/apptheme.dart';
// import 'package:ovrsr/widgets/easySnackBar.dart';
import 'package:ovrsr/widgets/main_drawer.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: SizedBox(
          height: 1000,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return const Column(
                  children: [
                    PlayerWidget(),
                    Divider(),
                    Expanded(child: _WebViewWidget()),
                  ],
                );
              }

              return const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: PlayerWidget()),
                  // VerticalDivider(), Maybe we'll use this if we want to have some text or notepad to the side.
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
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController.fromVideoId(
        videoId: 'gCRNEJxDJKM',
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      ),
      aspectRatio: 16 / 9,
    );
  }
}

class _WebViewWidget extends StatefulWidget {
  const _WebViewWidget();

  @override
  State<_WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<_WebViewWidget> {
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()..loadRequest(Uri.https('flutter.dev'));
  }

  late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
