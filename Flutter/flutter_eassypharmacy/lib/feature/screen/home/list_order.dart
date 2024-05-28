import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class ListOrder extends StatefulWidget {
  const ListOrder({super.key});

  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
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
  Widget build(BuildContext context) {
    // print("id user: $idUser");
    return BlocProvider(
      create: (context) => GetCartCubit()..getCart([]),
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
          onPressed: () {},
        ),
        const ColumnDivider(padding: space8),
      ],
    );
  }
}
