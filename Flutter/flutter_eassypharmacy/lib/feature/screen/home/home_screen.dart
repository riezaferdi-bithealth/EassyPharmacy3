import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

import 'list_order.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int tabController = 0;
  bool isViewTypeGrid = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetListMedicinesCubit(),
      child: Scaffold(
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
                        if (isViewTypeGrid == false) {
                          isViewTypeGrid = true;
                        } else {
                          isViewTypeGrid = false;
                        }
                        setState(() {});
                      },
                      child: Container(
                        color: systemPrimaryColor,
                        padding: const EdgeInsets.all(space8),
                        child: Row(
                          children: [
                            Icon(
                              isViewTypeGrid == true
                                  ? Icons.grid_view_rounded
                                  : Icons.list_rounded,
                            ),
                            const RowDivider(padding: space4),
                            Text(
                              isViewTypeGrid == true ? gridView : listView,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const ColumnDivider(padding: space8),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: isViewTypeGrid == true
                      ? const GridViewListMedicines()
                      : const ListViewListMedicines(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
