import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'package:intl/intl.dart';

class DetailHistoryOrdersPage extends StatefulWidget {
  final int? id;
  final String? name;
  final String? desc;
  final int? prices;
  final int? stocks;
  final String? image;

  const DetailHistoryOrdersPage({
    this.id,
    this.name,
    this.desc,
    this.prices,
    this.stocks,
    this.image,
    super.key,
  });

  @override
  State<DetailHistoryOrdersPage> createState() => _DetailHistoryOrdersPageState();
}

class _DetailHistoryOrdersPageState extends State<DetailHistoryOrdersPage> {
  String? isLogin;

  final oCcy = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  _stateToken() async {
    isLogin = await AccountHelper.getAuthToken();
    setState(() {});
  }

  onClickedCart(BuildContext context) {
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

  @override
  void initState() {
    super.initState();
    _stateToken();
  }

  @override
  void dispose() {
    super.dispose();
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
      body: Padding(
        padding: const EdgeInsets.all(space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(space8)),
              child: Image.network(
                widget.image!,
                fit: BoxFit.fill,
                // scale: imageScaleListMedicine,
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 1.5,
              ),
            ),
            Text(
              widget.name!,
              style: p16.primary.normal,
            ),
            const ColumnDivider(padding: space4),
            Row(
              children: [
                Text(
                  stock,
                  style: p14.primary.normal,
                ),
                Text(
                  widget.stocks.toString(),
                  style: p14.primary.normal,
                ),
              ],
            ),
            const ColumnDivider(padding: space4),
            Row(
              children: [
                Text(
                  price,
                  style: p14.primary.normal,
                ),
                Text(
                  oCcy.format(widget.prices),
                  style: p14.primary.normal,
                ),
              ],
            ),
            const ColumnDivider(padding: space4),
            Text(
              "desc: ${widget.desc!}",
              style: p16.primary.normal,
            ),
            const ColumnDivider(padding: 50),
            GeneralButton.text(
              addToCart,
              padding: const EdgeInsets.symmetric(vertical: space12),
              buttonSize: ButtonSize.large,
              backgroundColor: systemPrimaryColor,
              width: double.infinity,
              // height: 56,
              circular: space12,
              onPressed: () {
                onClickedCart(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
