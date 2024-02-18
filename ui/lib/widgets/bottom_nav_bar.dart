import 'package:app/screens/screens.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withAlpha(100),
      items: [
        BottomNavigationBarItem(
          label: 'News',
          icon: Container(
            margin: const EdgeInsets.only(left: 50),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, News.routeName);
              },
              icon: const Icon(Icons.newspaper_rounded),
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: 'Chat',
          icon: Container(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Chat.routeName);
              },
              icon: const Icon(Icons.message_rounded),
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Container(
            margin: const EdgeInsets.only(right: 50),
            child: IconButton(
              onPressed: () {
                print('no profile screen yet');
              },
              icon: const Icon(Icons.person_3),
            ),
          ),
        ),
      ],
    );
  }
}
