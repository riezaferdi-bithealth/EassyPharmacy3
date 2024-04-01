import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/core.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(eassyPharmacy),
          ],
        ),
      ),
    );
  }
}
