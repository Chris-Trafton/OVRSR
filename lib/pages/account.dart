import 'dart:ffi';

import 'package:flutter/material.dart';
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
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
          child: const SingleChildScrollView(
            child: Center(
                child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text("Account"),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Edit"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Account Name"),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Account Email"),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Account Password"),
                  ],
                ),
              ],
            )),
          )),
    );
  }
}
