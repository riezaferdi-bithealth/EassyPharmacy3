import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class ListOrder extends StatefulWidget {
  const ListOrder({super.key});

  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  @override
  void initState() {
    // coursesFuture = getCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Widget topBarSection() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: ListViewCart(listCart: listOrderName),
      ),
    );
  }

  Widget rowLineProfileDivider() {
    return Column(
      children: [
        const ColumnDivider(padding: space8),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 200,
          color: systemPrimary50Color,
        ),
        const ColumnDivider(padding: space8),
      ],
    );
  }

  Widget bottomBarSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("TOTAL HARGA: Rp ${totalPriceGlobal.value},-"),
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
