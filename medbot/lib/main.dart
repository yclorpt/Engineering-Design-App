// import 'package:flutter/material.dart';
// import 'package:medbot/pages/home_page-this-one.dart';

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//       theme: ThemeData(
//           brightness: Brightness.light,
//           scaffoldBackgroundColor: const Color.fromARGB(255, 239, 239, 239),
//           primaryColor: const Color.fromARGB(255, 0, 0, 0)),
//     );
//   }
// }

import 'package:medbot/pages/screens.dart';
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
