import 'package:flutter/material.dart';
import 'package:ovrsr/pages/account.dart';
import 'package:ovrsr/pages/home.dart';
import 'package:ovrsr/pages/login.dart';
import 'package:ovrsr/pages/URLentry.dart';
import 'package:ovrsr/utils/apptheme.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppTheme.accent,
            ),
            child: Image.asset(
              'assets/images/Logo_Light.png',
              height: 40,
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('URL Entry'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UrlEntryPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Account'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AccountPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              // clear the stack and start with the login page
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
