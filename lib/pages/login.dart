//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ovrsr/utils/apptheme.dart';
import 'package:ovrsr/utils/apptheme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<LoginPage> createState() => _LoginPage();
}

final _formKey = GlobalKey<FormState>();

class _LoginPage extends State<LoginPage> {
  var _isLoading = false;
  var _isObscure = true;
  var _isInit = true;
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUserName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isLogin ? const Text('Login') : const Text('Sign Up'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/Logo_Dark.png'),
                      ),
                      border: Border.all(
                        width: 3,
                        color: AppTheme.darkAccent,
                        style: BorderStyle.solid,
                      ),
                    )
                    // decoration: BoxDecoration(
                    //   image: const DecorationImage(
                    //     // image: AssetImage('assets/images/OVRSR_DARK')),
                    //     image: AssetImage('assets/images/OVRSR_DARK.png'),
                    //   ),
                    //   // borderRadius: const BorderRadius.only(
                    //   //   topRight: Radius.circular(40),
                    //   // ),
                    //   // border: Border.all(
                    //   //   width: 3,
                    //   //   color: const Color.fromARGB(255, 6, 53, 60),
                    //   //   style: BorderStyle.solid,
                    //   // ),
                    // ),
                    ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'OVRSR',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 650,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          if (!_isLogin)
                            TextFormField(
                              autocorrect: true,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                labelStyle: GoogleFonts.jacquesFrancois(),
                                label: const Text('Username'),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Username Cannot Be Left Blank';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredUserName = value!;
                              },
                            ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            maxLength: 320,
                            autocorrect: true,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              labelStyle: GoogleFonts.jacquesFrancois(),
                              label: const Text('Email'),
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email Cannot Be Left Blank';
                              }
                              final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                              ).hasMatch(value);
                              if (!emailValid) {
                                return 'Please Enter a Valid Email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelStyle: GoogleFonts.jacquesFrancois(),
                              label: const Text('Password'),
                              filled: true,
                              suffixIcon: IconButton(
                                icon: _isObscure
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                            ),
                            obscureText: _isObscure,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Password Cannot Be Left Blank';
                              }
                              if (value.length < 5) {
                                return 'Password cannot be less than five characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => {},
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : _isLogin
                          ? const Text('Log In')
                          : const Text('Sign Up'),
                ),
                Flexible(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 50.0),
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _isLogin
                              ? const Text('Don\'t have an account?')
                              : const Text('Have an account?'),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: _isLogin
                                ? const Text('Sign Up')
                                : const Text('Log In'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
