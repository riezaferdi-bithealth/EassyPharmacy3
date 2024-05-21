import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

import '../screen/home/detail_page.dart';

class GridViewListMedicines extends StatefulWidget {
  final TextEditingController? controller;
  const GridViewListMedicines({this.controller, super.key});

  @override
  State<GridViewListMedicines> createState() => _GridViewListMedicinesState();
}

class _GridViewListMedicinesState extends State<GridViewListMedicines>
    with SingleTickerProviderStateMixin {
  String? isLogin;

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
    super.initState();
    _stateToken();
  }

  @override
  Widget build(BuildContext context) {
    //make container for list of medicines
    return BlocConsumer<GetListMedicinesCubit, GetListMedicinesState>(
      builder: (context, state) {
        if (state is LoadingGetListMedicines) {
        } else if (state is NotLoadedGetListMedicines) {
        } else if (state is LoadedGetListMedicines) {
          // print("ada: ${widget.controller!.text}");
          return state.listData.data!.isEmpty
              ? const SearchNotFound()
              : GridView.count(
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: ((MediaQuery.of(context).size.width / 2) /
                      (MediaQuery.of(context).size.height / 3.4)),
                  children: List.generate(state.listData.data!.length, (index) {
                    var item = state.listData.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailPage(
                            id: item.id,
                            name: item.name,
                            image: item.image,
                            prices: item.price,
                            stocks: item.stock,
                            desc: item.desc,
                          );
                        }));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(space8),
                        padding: const EdgeInsets.all(space8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(space8),
                          color: systemPrimary50Color,
                          border: Border.all(
                            color: systemPrimaryColor,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(space8)),
                              child: Image.network(
                                item.image ?? Assets.noNetworkImage,
                                fit: BoxFit.fill,
                                // scale: imageScaleListMedicine,
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 2,
                              ),
                            ),
                            Text(
                              item.name!,
                              style: p16.primary.normal,
                            ),
                            const ColumnDivider(padding: space4),
                            Row(
                              children: [
                                Text(
                                  stock,
                                  style: p14.primary.normal,
                                ),
                                Text(
                                  item.stock.toString(),
                                  style: p14.primary.normal,
                                ),
                              ],
                            ),
                            const ColumnDivider(padding: space4),
                            GeneralButton.text(
                              addToCart,
                              padding:
                                  const EdgeInsets.symmetric(vertical: space12),
                              buttonSize: ButtonSize.small,
                              backgroundColor: systemPrimaryColor,
                              width: double.infinity,
                              // height: 56,
                              circular: space12,
                              onPressed: () {
                                onClickedCart(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
        }
        return const SizedBox.shrink();
      },
      listener: (context, state) async {},
    );
  }
}
