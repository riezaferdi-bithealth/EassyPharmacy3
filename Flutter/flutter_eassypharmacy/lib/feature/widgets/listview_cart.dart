import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class ListViewCart extends StatefulWidget {
  const ListViewCart({super.key});

  @override
  State<ListViewCart> createState() => _ListViewCartState();
}

class _ListViewCartState extends State<ListViewCart> {
  String? isLogin;
  int num = 1;
  final List<int> totalPrice = [];

  void removeCartData(List<dynamic> listToRemove) {
    context.read<RemoveCartCubit>().removeCart(listToRemove);
    Commons().snackbarError(context, itemRemoved);
    _handleRefresh();
  }

  Future<void> _handleRefresh() async {
    // Simulate a network request delay
    await Future.delayed(const Duration(seconds: delayRefreshCart));

    setState(() {
      context.read<GetCartCubit>().getCart([]);
    });
  }

  stateTotalPrice(int qty, int price) {
    totalPrice.add(qty * price);
    return MathHelper().oCcy.format(qty * price);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetCartCubit, GetCartState>(
      builder: (context, state) {
        if (state is LoadingGetCart) {
        } else if (state is NotLoadedGetCart) {
        } else if (state is LoadedGetCart) {
          return state.listData.isEmpty
              ? Container(
                  height: double.infinity,
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
                  child: const Center(
                    child: CartIsEmpty(),
                  ),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.listData.length,
                    itemBuilder: (context, index) {
                      var item = state.listData[index];
                      return Container(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(space8)),
                                  child: CachedNetworkImage(
                                    imageUrl: item.image!,
                                    fit: BoxFit.fill,
                                    height:
                                        MediaQuery.of(context).size.height / 12,
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    placeholder: (context, url) => const Center(
                                      child: SizedBox(
                                        height: space56,
                                        width: space56,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(Assets.noNetworkImage),
                                  ),
                                ),
                                const RowDivider(padding: space16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name!,
                                                style: p16.black.semiBold,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                MathHelper()
                                                    .oCcy
                                                    .format(item.price),
                                                style: p12.primary.normal,
                                              ),
                                              const ColumnDivider(
                                                  padding: space16),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              removeCartData([
                                                {
                                                  "id": item.id,
                                                  "name": item.name,
                                                  "price": item.price,
                                                }
                                              ]);
                                            },
                                            child: Icon(
                                              Assets.removeCart,
                                              color: systemRedColor,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            color: systemWhiteColor,
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<GetCartCubit>()
                                                        .addQty(
                                                          state.listData,
                                                          item.id!,
                                                        );
                                                    setState(() {});
                                                  },
                                                  child:
                                                      const Icon(Assets.addQty),
                                                ),
                                                Text(
                                                  item.qty.toString(),
                                                  style: p18.primary.normal,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (item.qty! > 1) {
                                                      context
                                                          .read<GetCartCubit>()
                                                          .subsQty(
                                                            state.listData,
                                                            item.id!,
                                                          );
                                                    }
                                                    setState(() {});
                                                  },
                                                  child:
                                                      const Icon(Assets.subQty),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Total: ${stateTotalPrice(item.qty!, item.price!)}",
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
                  ),
                );
        }
        return const SizedBox.shrink();
      },
      listener: (context, state) async {},
    );
  }
}
