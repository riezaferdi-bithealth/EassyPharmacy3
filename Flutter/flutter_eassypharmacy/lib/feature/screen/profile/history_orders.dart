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
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [
                0.7,
                1,
              ],
              colors: [
                systemWhiteColor,
                systemBlueShade200Color,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: space16, right: space16),
            child: Column(
              children: [
                topBarSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topBarSection() {
    return const Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: ListViewHistoryOrders(),
      ),
    );
  }
}
