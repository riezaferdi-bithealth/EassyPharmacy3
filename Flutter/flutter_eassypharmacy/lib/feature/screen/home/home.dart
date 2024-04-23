import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'package:flutter_eassypharmacy/feature/screen/login_or_register/login_or_register.dart';

import 'list_order.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabController = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: systemPrimaryColor,
        // tooltip: 'Increment',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const ListOrder();
          }));
        },
        label: Text(
          checkOrders,
          style: p14.white.bold,
        ),
        icon: const Icon(Icons.list_alt, color: Colors.white, size: 28),
      ),
      body: Container(
        color: systemWhiteColor,
        height: double.infinity,
        child: Column(
          children: [
            const ColumnDivider(padding: topBarPadding),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginOrRegisterPage();
                }));
              },
              child: Text(
                eassyPharmacy,
                style: p30.primary.bold,
              ),
            ),
            Text(
              sloganStore,
              style: p16.primary.medium,
            ),
            const ColumnDivider(padding: space16),
            //search button
            Row(
              children: [
                const Expanded(child: SearchTopBar()),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GeneralButton.custom(
                    padding: const EdgeInsets.symmetric(vertical: space12),
                    buttonSize: ButtonSize.small,
                    width: MediaQuery.of(context).size.width / 3.7,
                    // height: 56,
                    circular: space12,
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return const Blank();
                      // }));
                    },
                    child: Container(
                      color: systemPrimaryColor,
                      padding: const EdgeInsets.all(space8),
                      child: const Row(
                        children: [
                          Icon(Icons.grid_view_rounded),
                          RowDivider(padding: space4),
                          Text(gridView),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const ColumnDivider(padding: space8),
            const Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: GridViewListMedicines(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
