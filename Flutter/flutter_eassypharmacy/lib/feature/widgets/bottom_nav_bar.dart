import 'package:flutter_eassypharmacy/core/core.dart';

class BottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onClicked;
  const BottomBar({
    super.key,
    required this.selectedIndex,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onClicked,
      selectedItemColor: systemPrimaryColor,
      unselectedItemColor: systemBlackColor,
      items: const [
        BottomNavigationBarItem(
          label: home,
          icon: Assets.homeIcon,
        ),
        BottomNavigationBarItem(
          label: cart,
          icon: Assets.cartIcon,
        ),
        BottomNavigationBarItem(
          label: profile,
          icon: Assets.profileIcon,
        ),
      ],
    );
  }
}
