import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: systemWhiteColor,
        height: double.infinity,
        child: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ColumnDivider(padding: topBarPadding),
              Text(eassyPharmacy),
              ColumnDivider(padding: space16),
              ListMedicines(),
            ],
          ),
        ),
      ),
    );
  }
}
