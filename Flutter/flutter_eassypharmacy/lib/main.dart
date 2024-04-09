import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: splashNav,
    routes: {
      splashNav: (context) => const SplashPage(),
      homeNav: (context) => const MainApp(),
      // Add other routes for your app screens here
    },
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Widget> screens = [
    const HomePage(),
    const Profile(),
  ];

  void onClicked(int index) {
    setState(() {
      indexStart = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screens.elementAt(indexStart),
        bottomNavigationBar: BottomBar(
          selectedIndex: indexStart,
          onClicked: onClicked,
        ),
      ),
    );
  }
}
