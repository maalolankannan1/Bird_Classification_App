import 'package:flutter/material.dart';
import './screens/bird_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BIRD_FINDER',
      theme: ThemeData.dark(),
      home: BirdScreen(),
    );
  }
}
