import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GC Cloud',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
            splashIconSize: 800,
            duration: 3000,
            splash: Image.asset('assets/gccloudlogoremovebg.png'),
            nextScreen: loginPage(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: splashbgcolor)
    );
  }
}




