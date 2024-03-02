import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'features/app/splash_screen/splash_screen.dart';

import 'features/pages/home_page.dart';
import 'features/user_auth/presentation/pages/home_page2.dart';

import 'features/user_auth/presentation/pages/login_page.dart';
import 'features/user_auth/presentation/pages/signup_page.dart';
import 'firebase_options.dart';
void  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Helmet Detection",
      routes: {
        '/': (context) =>   const SplashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/login': (context) =>  const LoginPage(),
        '/signUp': (context) => const SignUpPage(),
        //'/home': (context) =>  HomePage(),
        '/home2': (context) => const HomePage2(),
      },
    );
  }
}