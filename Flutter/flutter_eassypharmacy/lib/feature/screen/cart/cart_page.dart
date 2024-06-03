import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? idUser;

  final oCcy = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

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
      // isDismissible: false,
      // enableDrag: false,
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
                      Expanded(
                        child: BlocConsumer<OrderCartCubit, OrderCartState>(
                          listener: (context, state) {
                            if (state is NotLoadedOrderCart) {
                              Commons().snackbarError(context, state.error);
                            } else if (state is LoadedOrderCart) {
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
                          builder: (context, state) => state is LoadingOrderCart
                              ? LoadingButton(
                                  color: systemPrimaryColor,
                                  height: space56,
                                )
                              : GeneralButton.text(
                                  proceed,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  buttonSize: ButtonSize.large,
                                  backgroundColor: systemPrimaryColor,
                                  width: double.infinity,
                                  circular: 8,
                                  onPressed: () {
                                    contextMain
                                        .read<OrderCartCubit>()
                                        .orderCart(listItems);
                                    contextMain
                                        .read<RemoveCartCubit>()
                                        .removeCart(listItems);
                                  },
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
        BlocProvider(
          create: (context) => OrderCartCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            cart,
            style: p24.primary.semiBold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(space16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              topBarSection(),
              bottomBarSection(context),
            ],
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
        child: ListViewCart(),
      ),
    );
  }

  Widget bottomBarSection(BuildContext context) {
    return BlocConsumer<GetCartCubit, GetCartState>(
      builder: (context, state) {
        if (state is LoadingGetCart) {
        } else if (state is NotLoadedGetCart) {
        } else if (state is LoadedGetCart) {
          var listItems = state.listData;
          var totalPrice = state.totalPrice;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              totalPrice == 0
                  ? const SizedBox.shrink()
                  : Text(
                      "TOTAL PRICE: ${oCcy.format(totalPrice)}",
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
          );
        }
        return const SizedBox.shrink();
      },
      listener: (context, state) async {},
    );
  }
}
