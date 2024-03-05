import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ovrsr/utils/apptheme.dart';
import 'package:ovrsr/widgets/easySnackBar.dart';
import 'package:ovrsr/widgets/main_drawer.dart';
import 'package:youtube_video_player/potrait_player.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/Logo_Light.png',
              height: 40,
            ),
          ],
        ),
      ),
      drawer: MainDrawer(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: PotraitPlayer(
                  //link: 'https://youtube.com/live/_TAcY9b1d10?feature=share',
                  link: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
                  aspectRatio: 16 / 9),
            )
          ],
        ),
      ),
    );
  }
}
