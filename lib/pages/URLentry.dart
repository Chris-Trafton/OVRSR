import 'package:flutter/material.dart';
import 'package:ovrsr/widgets/main_drawer.dart';

class UrlEntryPage extends StatelessWidget {
  const UrlEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('URL Entry'),
      ),
      drawer: const MainDrawer(),
      body: const Center(
        child: Text('URL Entry Page'),
      ),
    );
  }
}
