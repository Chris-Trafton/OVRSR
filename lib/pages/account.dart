//https://medium.flutterdevs.com/verify-email-and-reset-password-in-flutter-31d07db1db76
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovrsr/pages/password_reset.dart';
import 'package:ovrsr/provider/userProfileProvider.dart';
import 'package:ovrsr/utils/apptheme.dart';
import 'package:ovrsr/widgets/formatters/obscure_text.dart';
import 'package:ovrsr/widgets/main_drawer.dart';
//change user https://stackoverflow.com/questions/47659167/firebase-change-usernameemail-of-registered-user

//import 'package:http/http.dart' as http;
class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  var _isEditUsername = false;
  var _isEditEmail = false;

  @override
  Widget build(BuildContext context) {
    UserProfileProvider _UserProfile = ref.read(userProfileProvider);
    User? user = FirebaseAuth.instance.currentUser;

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
                    const SizedBox(
                      width: 150,
                    ),
                    const SizedBox(
                      width: 150,
                      child: Text('Username:', style: TextStyle(fontSize: 30)),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    SizedBox(
                      width: 300,
                      //make it change based off the bool
                      child: !_isEditUsername
                          ? Text(_UserProfile.userName,
                              style: const TextStyle(fontSize: 30))
                          : TextFormField(
                              initialValue: _UserProfile.userName,
                              onChanged: (value) {
                                _UserProfile.userName = value;
                              },
                              style: const TextStyle(fontSize: 30),
                            ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 128, 109, 0),
                          foregroundColor: AppTheme.light,
                        ),
                        onPressed: () async => {
                              _isEditUsername = !_isEditUsername,
                              setState(() {}),
                              await _UserProfile.writeUserProfileToDb(),
                            },
                        child: _isEditUsername
                            ? const Icon(Icons.save)
                            : const Icon(Icons.edit))
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                //ACCOUNT EMAIL
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 150,
                    ),
                    const SizedBox(
                      width: 150,
                      child: Text('Email:', style: TextStyle(fontSize: 30)),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    SizedBox(
                      width: 300,
                      child: !_isEditEmail
                          ? Text(_UserProfile.email,
                              style: const TextStyle(fontSize: 30))
                          : TextFormField(
                              initialValue: _UserProfile.email,
                              onChanged: (value) {
                                _UserProfile.email = value;
                              },
                              style: const TextStyle(fontSize: 30),
                            ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(0, 131, 126, 98),
                          foregroundColor: AppTheme.light,
                        ),
                        onPressed: () async => {
                              _isEditEmail = !_isEditEmail,
                              setState(() {}),
                              await _UserProfile.writeUserProfileToDb(),
                              await user?.updateEmail(_UserProfile.email),
                            },
                        child: _isEditEmail
                            ? const Icon(Icons.save)
                            : const Icon(Icons.edit))
                  ],
                ),
                //ACCOUNT PASSWORD
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 150,
                    ),
                    const SizedBox(
                      width: 150,
                      child: Text('Password:', style: TextStyle(fontSize: 30)),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const SizedBox(
                        width: 300,
                        // child: Text(obscureText(_UserProfile.password),
                        //     style: const TextStyle(fontSize: 30)),
                        child:
                            Text('********', style: TextStyle(fontSize: 30))),
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 128, 109, 0),
                          foregroundColor: AppTheme.light,
                        ),
                        onPressed: () => Navigator.of(context).push<String>(
                            MaterialPageRoute(
                                builder: (context) => ResetPasswordPage())),
                        child: const Icon(Icons.edit)),
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
