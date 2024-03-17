import 'package:flutter/material.dart';
import 'package:ovrsr/widgets/main_drawer.dart';

class UrlEntryPage extends StatefulWidget {
  const UrlEntryPage({super.key});

  @override
  State<UrlEntryPage> createState() => _UrlEntryPageState();
}

class _UrlEntryPageState extends State<UrlEntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('URL Entry'),
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
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter URL',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
              onFieldSubmitted: (String value) {
                print(value);
              },
            ),
            // List of previous URLs
            // ListView.builder(itemBuilder: itemBuilder)
          ],
        ),
      ),
    );
  }
}
