import 'package:app/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});
  static const routeName = '/chat';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, actions: []),
      bottomNavigationBar: const BottomNavBar(index: 1),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [],
      ),
    );
  }
}
