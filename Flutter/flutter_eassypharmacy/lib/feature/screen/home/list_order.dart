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
          yourOrders,
          style: p24.primary.semiBold,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: systemPrimaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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

  // Widget topBarSection() {
  //   return Column(
  //     children: [
  //       const ColumnDivider(padding: topBarPadding),
  //       const Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Text("Name"),
  //           Text("Qty"),
  //           Text("Price"),
  //           Text("Total"),
  //         ],
  //       ),
  //       rowLineProfileDivider(),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         // mainAxisSize: MainAxisSize.min,
  //         children: List.generate(
  //           listOrderName.length,
  //           (index) {
  //             var items = listOrderName[index];
  //             var qty = listOrderQty[index];
  //             var price = listOrderPrice[index];
  //             var total = qty * price;
  //             stateTotalPrice(total);
  //             return Column(
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     Text(items),
  //                     Text(qty.toString()),
  //                     Text("Rp ${price.toString()},-"),
  //                     Text("Rp ${(total).toString()},-"),
  //                   ],
  //                 ),
  //                 rowLineProfileDivider(),
  //                 // index + 1 == listOrderName.length
  //                 // ? Row(
  //                 //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 //   children: [
  //                 //     const Text(""),
  //                 //     const Text(""),
  //                 //     const Text(""),
  //                 //     Text("Rp ${totalPrice.reduce((a, b) => a + b)},-"),
  //                 //   ],
  //                 // )
  //                 // : const SizedBox.shrink(),
  //               ],
  //             );
  //           },
  //         ),
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         // crossAxisAlignment: CrossAxisAlignment.end,
  //         children: [
  //           const Text(""),
  //           const Text(""),
  //           const Text(""),
  //           Text("Rp ${totalPrice.reduce((a, b) => a + b)},-"),
  //         ],
  //       ),
  //     ],
  //   );
  // }

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
