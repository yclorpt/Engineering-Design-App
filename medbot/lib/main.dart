import 'package:flutter/material.dart';
import 'package:medbot/pages/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color.fromARGB(255, 239, 239, 239),
          primaryColor: const Color.fromARGB(255, 0, 0, 0)),
    );
  }
}
