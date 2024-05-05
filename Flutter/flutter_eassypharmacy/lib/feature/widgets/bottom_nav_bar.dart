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
      currentIndex: selectedIndex,
      onTap: onClicked,
      selectedItemColor: systemPrimaryColor,
      // backgroundColor: Colors.blue,
      unselectedItemColor: systemBlackColor,
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
