import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class DetailHistoryOrdersPage extends StatefulWidget {
  final int? idOrder;
  final String? dateOrder;
  final List<CartItems>? listOrder;

  const DetailHistoryOrdersPage({
    this.idOrder,
    this.dateOrder,
    this.listOrder,
    super.key,
  });

  @override
  State<DetailHistoryOrdersPage> createState() =>
      _DetailHistoryOrdersPageState();
}

class _DetailHistoryOrdersPageState extends State<DetailHistoryOrdersPage> {
  String? isLogin;
  final List<int> totalPrice = [];

  stateTotalPrice(int price) {
    totalPrice.add(price);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(space16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              topBarSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget topBarSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ColumnDivider(padding: topBarPadding),
        Text(
          "ID ORDER: ${widget.idOrder.toString()}",
          style: p16.primary.medium,
        ),
        const ColumnDivider(padding: space8),
        Text(
          "DATE ORDER: ${widget.dateOrder.toString()}",
          style: p16.primary.medium,
        ),
        const ColumnDivider(padding: space8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(name),
            Text(qty),
            Text(price),
            Text(total),
          ],
        ),
        rowLineProfileDivider(),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.listOrder!.length,
              (index) {
                var items = widget.listOrder![index];
                int? qtyItems = widget.listOrder![index].qty;
                int? priceItems = widget.listOrder![index].price;
                var totalItems = qtyItems! * priceItems!;
                stateTotalPrice(totalItems);
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(items.id!.toString()),
                        Text(qtyItems.toString()),
                        Text(MathHelper().oCcy.format(priceItems)),
                        Text(MathHelper().oCcy.format(totalItems)),
                      ],
                    ),
                    rowLineProfileDivider(),
                  ],
                );
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(""),
            const Text(""),
            const Text(""),
            Text(MathHelper().oCcy.format(totalPrice.reduce((a, b) => a + b))),
          ],
        ),
      ],
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
}
