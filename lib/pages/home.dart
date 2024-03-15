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
      body: const Center(),
    );
  }
}
