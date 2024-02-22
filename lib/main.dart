import 'package:flutter/material.dart';
import 'package:ovrsr/pages/home.dart';
import 'package:ovrsr/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ovrsr/utils/apptheme.dart';
//import 'firebase_options.dart';

//https://blog.canopas.com/google-authentication-with-firebase-for-flutter-desktop-apps-d8bbcd8f5073

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OVSRS',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
      ),
      //color: Colors.purple,
      // scaffoldBackgroundColor: const Colors.white,
      home: LoginPage(),
    );
  }
}
