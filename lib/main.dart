//https://www.youtube.com/watch?v=SmmHdxAw8wA
//1:26
//google auth
//https://www.youtube.com/watch?v=PkvW5WoUonQ
import 'package:flutter/material.dart';
import 'package:ovrsr/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MetaTube',
      home: HomeScreen(),
    );
  }
}
