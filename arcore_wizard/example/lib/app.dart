import 'package:arcore_flutter_plugin_example/splashScreen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARCore Wizard',
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
