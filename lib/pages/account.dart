//https://medium.flutterdevs.com/verify-email-and-reset-password-in-flutter-31d07db1db76
import 'package:flutter/material.dart';
import 'package:ovrsr/utils/apptheme.dart';
import 'package:ovrsr/widgets/main_drawer.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Account'),
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
      body: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/Logo_Light.png',
                  height: 200,
                ),
                const SizedBox(
                  height: 50,
                ),
                //ACCOUNT NAME
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Account', style: TextStyle(fontSize: 30)),
                    const SizedBox(
                      width: 50,
                    ),
                    const Text('ACCOUNT_NAME', style: TextStyle(fontSize: 30)),
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 128, 109, 0),
                          foregroundColor: AppTheme.light,
                        ),
                        onPressed: () => {},
                        child: const Icon(Icons.edit))
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                //ACCOUNT EMAIL
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('EMAIL', style: TextStyle(fontSize: 30)),
                    const SizedBox(
                      width: 50,
                    ),
                    const Text('ACCOUNT_EMAIL', style: TextStyle(fontSize: 30)),
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 128, 109, 0),
                          foregroundColor: AppTheme.light,
                        ),
                        onPressed: () => {},
                        child: const Icon(Icons.edit))
                  ],
                ),
                //ACCOUNT PASSWORD
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Password', style: TextStyle(fontSize: 30)),
                    const SizedBox(
                      width: 50,
                    ),
                    const Text('ACCOUNT_PASSWORD',
                        style: TextStyle(fontSize: 30)),
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 128, 109, 0),
                          foregroundColor: AppTheme.light,
                        ),
                        onPressed: () => {},
                        child: const Icon(Icons.edit))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
