import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

import '../screen/home/detail_page.dart';

class ListViewListMedicines extends StatefulWidget {
  final TextEditingController? controller;
  const ListViewListMedicines({this.controller, super.key});

  @override
  State<ListViewListMedicines> createState() => _ListViewListMedicinesState();
}

class _ListViewListMedicinesState extends State<ListViewListMedicines> {
  String? isLogin;

  _stateToken() async {
    isLogin = await AccountHelper.getAuthToken();
    setState(() {});
  }

  onClickedAddtoCart(BuildContext context, List<dynamic> listToAdd) {
    if (isLogin != null) {
      context.read<GetCartCubit>().getCart(listToAdd);
      Commons().snackbarSuccess(context, itemAdded);
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
    return BlocConsumer<GetListMedicinesCubit, GetListMedicinesState>(
      builder: (context, state) {
        if (state is LoadingGetListMedicines) {
        } else if (state is NotLoadedGetListMedicines) {
        } else if (state is LoadedGetListMedicines) {
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
                        padding: const EdgeInsets.all(space8),
                        margin: const EdgeInsets.all(space8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(space8),
                          color: systemWhiteColor,
                          border: Border.all(
                            color: systemPrimaryColor,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              trailing: GeneralButton.text(
                                item.stock == 0 ? outOfStock : addToCart,
                                padding: const EdgeInsets.symmetric(
                                    vertical: space12),
                                buttonSize: ButtonSize.small,
                                backgroundColor: item.stock == 0
                                    ? systemRedColor
                                    : systemPrimaryColor,
                                width: MediaQuery.of(context).size.width / 4,
                                // height: 56,
                                circular: space12,
                                onPressed: () {
                                  if (item.stock! > 0) {
                                    onClickedAddtoCart(context, [
                                      {
                                        "id": item.id,
                                        "name": item.name,
                                        "price": item.price,
                                        "image": item.image,
                                        "qty": 1
                                      }
                                    ]);
                                  }
                                },
                              ),
                              title: Text(
                                item.name!,
                                style: p16.primary.medium,
                                maxLines: 2,
                              ),
                              subtitle: Text(
                                "$stock ${item.stock}",
                                style: p14.primary.normal,
                              ),
                              leading: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(space12)),
                                child: CachedNetworkImage(
                                  imageUrl: item.image!,
                                  fit: BoxFit.fill,
                                  height: MediaQuery.of(context).size.height /
                                      10, //70
                                  width: MediaQuery.of(context).size.width /
                                      5, //120
                                  placeholder: (context, url) => const Center(
                                    child: SizedBox(
                                      height: space20,
                                      width: space20,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(Assets.noNetworkImage),
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
