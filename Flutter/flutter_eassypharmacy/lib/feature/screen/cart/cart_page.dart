import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? idUser;

  _stateToken() async {
    idUser = await AccountHelper.getUserId();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _stateToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showBottomSheetFilter(
      BuildContext contextMain, List<dynamic> listItems) async {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: systemWhiteColor,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 5.2,
          decoration: BoxDecoration(
            color: systemWhiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(space30),
              topRight: Radius.circular(space30),
            ),
          ),
          padding: const EdgeInsets.only(
            left: space20,
            right: space20,
            bottom: space20,
            top: space20,
          ),
          child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    orderProceedMessage,
                    style: p16.primary.medium,
                  ),
                  const ColumnDivider(padding: space30),
                  Row(
                    children: [
                      Expanded(
                        child: GeneralButton.text(
                          cancel,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          buttonSize: ButtonSize.large,
                          backgroundColor: systemPrimaryColor,
                          width: double.infinity,
                          onlyBorder: true,
                          isBorderWidth: true,
                          circular: 8,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const RowDivider(padding: space8),
                      MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => RemoveCartCubit(),
                          ),
                          BlocProvider(
                            create: (context) => OrderCartCubit(),
                          ),
                        ],
                        child: Expanded(
                          child: BlocConsumer<OrderCartCubit, OrderCartState>(
                            listener: (context, state) {
                              if (state is NotLoadedOrderCart) {
                                Commons().snackbarError(context, state.error);
                              } else if (state is LoadedOrderCart) {
                                for (var item in state.listData.data!) {
                                  List<dynamic> listItems = [];
                                  listItems.add({
                                    "id": item.id,
                                    "price": item.price,
                                  });
                                  context
                                      .read<RemoveCartCubit>()
                                      .removeCart(listItems);
                                }
                                
                                tabIndex.value = 0;

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RoutingPage(isResize: true),
                                  ),
                                  (route) => false,
                                );

                                Commons().snackbarSuccess(
                                  context,
                                  orderSuccessful,
                                );

                                return;
                              }
                            },
                            builder: (context, state) =>
                                state is LoadingOrderCart
                                    ? LoadingButton(
                                        color: systemPrimaryColor,
                                        height: space56,
                                      )
                                    : GeneralButton.text(
                                        proceed,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        buttonSize: ButtonSize.large,
                                        backgroundColor: systemPrimaryColor,
                                        width: double.infinity,
                                        circular: 8,
                                        onPressed: () {
                                          context
                                              .read<OrderCartCubit>()
                                              .orderCart(listItems);
                                        },
                                      ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetCartCubit()..getCart([]),
        ),
        BlocProvider(
          create: (context) => RemoveCartCubit()..removeCart([]),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            cart,
            style: p24.primary.semiBold,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            topBarSection(),
            bottomBarSection(context),
          ],
        ),
      ),
    );
  }

  Widget topBarSection() {
    return const Expanded(
      child: ListViewCart(),
    );
  }

  Widget bottomBarSection(BuildContext context) {
    return BlocConsumer<GetCartCubit, GetCartState>(
      builder: (context, state) {
        if (state is LoadingGetCart) {
        } else if (state is NotLoadedGetCart) {
        } else if (state is LoadedGetCart) {
          List<dynamic> listItems = [];
          for (var item in state.listData) {
            listItems.add({
              "id": item.id,
              "qty": item.qty,
              "name": item.name,
              "price": item.price,
              "total_price": item.qty! * item.price!,
            });
          }
          var totalPrice = state.totalPrice;
          return state.listData.isEmpty
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.all(space16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "TOTAL PRICE: ${MathHelper().oCcy.format(totalPrice)}",
                        style: p12.primary.medium,
                      ),
                      const ColumnDivider(padding: space8),
                      GeneralButton.text(
                        orderNow,
                        padding: const EdgeInsets.symmetric(vertical: space12),
                        buttonSize: ButtonSize.large,
                        backgroundColor: systemPrimaryColor,
                        width: double.infinity,
                        height: 56,
                        circular: space12,
                        onPressed: () {
                          showBottomSheetFilter(context, listItems);
                        },
                      ),
                      const ColumnDivider(padding: space8),
                    ],
                  ),
                );
        }
        return const SizedBox.shrink();
      },
      listener: (context, state) async {},
    );
  }
}
