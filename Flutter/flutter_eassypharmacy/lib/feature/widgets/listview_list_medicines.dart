import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

import '../screen/home/detail_page.dart';

class ListViewListMedicines extends StatefulWidget {
  const ListViewListMedicines({super.key});

  @override
  State<ListViewListMedicines> createState() => _ListViewListMedicinesState();
}

class _ListViewListMedicinesState extends State<ListViewListMedicines> {
  String? isLogin;

  void _initListMedicinesData() {
    context.read<GetListMedicinesCubit>().getListMedicines();
  }

  _stateToken() async {
    isLogin = await AccountHelper.getAuthToken();
  }

  onClickedCart(BuildContext context) {
    _stateToken();

    if (isLogin != null) {
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return const Blank();
      // }));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginOrRegisterPage();
          },
        ),
      );
    }
  }

  @override
  void initState() {
    _initListMedicinesData();
    super.initState();
    _stateToken();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetListMedicinesCubit, GetListMedicinesState>(
      builder: (context, state) {
        if (state is LoadingGetListMedicines) {
        } else if (state is NotLoadedGetListMedicines) {
        } else if (state is LoadedGetListMedicines) {
          //make container for list of medicines
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.listData.data!.length,
            itemBuilder: (context, index) {
              var item = state.listData.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        id: item.id,
                        name: item.name,
                        image: item.image,
                        prices: item.price,
                        stocks: item.stock,
                        desc: item.desc,
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
                        trailing: GeneralButton.text(
                          addToCart,
                          padding:
                              const EdgeInsets.symmetric(vertical: space12),
                          buttonSize: ButtonSize.small,
                          backgroundColor: systemPrimaryColor,
                          width: MediaQuery.of(context).size.width / 4,
                          // height: 56,
                          circular: space12,
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) {
                            //   return const ListOrder();
                            // }));
                          },
                        ),
                        title: Text(
                          item.name!,
                          style: p16.black.semiBold,
                          maxLines: 2,
                        ),
                        subtitle: Text(
                          "$stock ${item.stock}",
                          style: p12.primary.normal,
                        ),
                        leading: Container(
                          width: 70,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                item.image!,
                              ),
                            ),
                          ),
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
