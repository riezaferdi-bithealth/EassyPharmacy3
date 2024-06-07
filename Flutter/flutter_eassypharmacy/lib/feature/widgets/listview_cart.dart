import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

// import '../screen/home/detail_page.dart';

class ListViewCart extends StatefulWidget {
  final List<String>? listCart;
  const ListViewCart({this.listCart, super.key});

  @override
  State<ListViewCart> createState() => _ListViewCartState();
}

class _ListViewCartState extends State<ListViewCart> {
  String? isLogin;
  int num = 1;
  final List<int> totalPrice = [];

  void sumTotalPrice() {
    setState(() {
      totalPriceGlobal.value = totalPrice.reduce((a, b) => a + b);
    });
  }

  // void _initCartData() {
  //   context.read<GetCartCubit>().getCart(widget.controller!.text);
  // }

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

  stateTotalPrice(int qty, int price) {
    totalPrice.add(qty * price);
    // sumTotalPrice();
    return qty * price;
  }

  @override
  void initState() {
    // _initCartData();
    super.initState();
    _stateToken();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<GetCartCubit, GetCartState>(
    //   builder: (context, state) {
    //     if (state is LoadingGetCart) {
    //     } else if (state is NotLoadedGetCart) {
    //     } else if (state is LoadedGetCart) {
    //       //make container for list of medicines
    //       return state.listData.data!.isEmpty
    //           ? Text("SEARCH NOT FOUND")
    //           :
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.listCart!.length,
      itemBuilder: (context, index) {
        // var item = state.listData.data![index];
        return Container(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(Assets.noNetworkImage),
                      ),
                    ),
                  ),
                  RowDivider(padding: space8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listOrderName[index],
                          style: p16.black.semiBold,
                          maxLines: 2,
                        ),
                        Text(
                          listOrderPrice[index].toString(),
                          style: p12.primary.normal,
                        ),
                        ColumnDivider(padding: space16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: systemWhiteColor,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        listOrderQty[index]++;
                                      });
                                    },
                                    child: Icon(Assets.addQty),
                                  ),
                                  Text(
                                    listOrderQty[index].toString(),
                                    style: p18.primary.normal,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (listOrderQty[index] > 1) {
                                          listOrderQty[index]--;
                                        }
                                      });
                                    },
                                    child: Icon(Assets.subQty),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Total: ${stateTotalPrice(listOrderQty[index], listOrderPrice[index])}",
                              style: p18.primary.normal,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  //       return const SizedBox.shrink();
  //     },
  //     listener: (context, state) async {},
  //   );
  // }
}
