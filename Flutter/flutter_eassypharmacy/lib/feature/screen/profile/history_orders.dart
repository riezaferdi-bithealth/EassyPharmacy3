import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'package:flutter_eassypharmacy/feature/provider/bloc/account/get_history_order_cubit.dart';

class HistoryOrders extends StatefulWidget {
  const HistoryOrders({super.key});

  @override
  State<HistoryOrders> createState() => _HistoryOrdersState();
}

class _HistoryOrdersState extends State<HistoryOrders> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetHistoryOrderCubit()..getHistoryOrder(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            historyOrders,
            style: p24.primary.semiBold,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: systemPrimaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(space16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              topBarSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget topBarSection() {
    return const ListViewHistoryOrders();
  }
}
