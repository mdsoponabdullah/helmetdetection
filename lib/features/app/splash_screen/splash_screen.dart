import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/home_page.dart';
import '../../user_auth/presentation/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? email = prefs.getString('email');

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => email == null
                ? widget.child!
                : HomePage(
                    userId: email,
                  ),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Welcome To',
                    textStyle: const TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  TypewriterAnimatedText(
                    'helmet Detection App',
                    textStyle: const TextStyle(
                        color: Colors.pink,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
                onTap: () {
                  print("Tap Event");
                },
              ),
              Center(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 3),
                  height: Random().nextInt(8).toDouble(),
                  width: Random().nextInt(600).toDouble(),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(Random().nextInt(256),
                          Random().nextInt(256), Random().nextInt(256), 1)),
                ),
              )
            ],
          )),
    );
  }
}
