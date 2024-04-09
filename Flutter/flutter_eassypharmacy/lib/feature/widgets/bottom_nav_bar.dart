import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/config/theme_helper.dart';
import 'package:flutter_eassypharmacy/core/core.dart';

class BottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onClicked;
  const BottomBar({
    super.key,
    required this.selectedIndex,
    required this.onClicked,
  });

  // int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // currentIndex: index,
      // onTap: (value) {
      //   print(value);
      //   setState(() {
      //     index = value;
      //   });
      // },
      currentIndex: selectedIndex,
      onTap: onClicked,
      selectedItemColor: systemPrimaryColor,
      // backgroundColor: Colors.blue,
      unselectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
          label: home,
          icon: Assets.homeIcon,
        ),
        BottomNavigationBarItem(
          label: profile,
          icon: Assets.profileIcon,
        ),
      ],
    );
  }
}