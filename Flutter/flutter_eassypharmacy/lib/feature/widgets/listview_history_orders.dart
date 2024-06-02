import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'package:flutter_eassypharmacy/feature/provider/bloc/account/get_history_order_cubit.dart';

import '../screen/profile/detail_history_orders.dart';

class ListViewHistoryOrders extends StatefulWidget {
  const ListViewHistoryOrders({super.key});

  @override
  State<ListViewHistoryOrders> createState() => _ListViewHistoryOrdersState();
}

class _ListViewHistoryOrdersState extends State<ListViewHistoryOrders> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetHistoryOrderCubit, GetHistoryOrderState>(
      builder: (context, state) {
        if (state is LoadingGetHistoryOrder) {
        } else if (state is NotLoadedGetHistoryOrder) {
        } else if (state is LoadedGetHistoryOrder) {
          //make container for list of medicines
          return state.listData.isEmpty
              ? const SearchNotFound()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.listData.length,
                  itemBuilder: (context, index) {
                    var item = state.listData[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailHistoryOrdersPage(
                              idOrder: item.idStruct,
                              dateOrder: item.dateOrder ?? "-",
                              listOrder: item.data,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        color: systemPrimary50Color,
                        margin: const EdgeInsets.fromLTRB(
                          space16,
                          space8,
                          space16,
                          space8,
                        ),
                        padding: const EdgeInsets.all(space8),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                item.idStruct.toString(),
                                style: p16.black.semiBold,
                                maxLines: 2,
                              ),
                              subtitle: Text(
                                item.dateOrder ?? "-",
                                style: p12.primary.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        }
        return const SizedBox.shrink();
      },
      listener: (context, state) async {},
    );
  }
}
