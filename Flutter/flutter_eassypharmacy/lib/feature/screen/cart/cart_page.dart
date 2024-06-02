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

  void showBottomSheetFilter(BuildContext contextMain) async {
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
                        child: GeneralButton.text(
                          proceed,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          buttonSize: ButtonSize.large,
                          backgroundColor: systemPrimaryColor,
                          width: double.infinity,
                          circular: 8,
                          onPressed: () {},
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
    // print("id user: $idUser");
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetCartCubit()..getCart([]),
        ),
        BlocProvider(
          create: (context) => RemoveCartCubit()..removeCart([]),
        ),
        BlocProvider(
          create: (context) => OrderCartCubit()..orderCart([]),
        )
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
              bottomBarSection(),
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

  Widget bottomBarSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("TOTAL PRICE: Rp ${totalPriceGlobal.value},-"),
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
            showBottomSheetFilter(context);
          },
        ),
        const ColumnDivider(padding: space8),
      ],
    );
  }
}
