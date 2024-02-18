import 'screens/screens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health News',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/',
      routes: {
        News.routeName: (context) => const News(),
        Chat.routeName: (context) => const Chat(),
        Search.routeName: (context) => const Search(),
        ArticleScreen.routeName: (context) => const ArticleScreen(),
      },
    );
  }
}
