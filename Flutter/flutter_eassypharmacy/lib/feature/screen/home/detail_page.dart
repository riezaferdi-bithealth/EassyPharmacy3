import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class DetailPage extends StatefulWidget {
  final int? id;
  final String? name;
  final String? desc;
  final int? prices;
  final int? stocks;
  final String? image;

  const DetailPage({
    this.id,
    this.name,
    this.desc,
    this.prices,
    this.stocks,
    this.image,
    super.key,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? isLogin;

  _stateToken() async {
    isLogin = await AccountHelper.getAuthToken();
    setState(() {});
  }

  onClickedCart(BuildContext context, List<dynamic> listToAdd) {
    if (isLogin != null) {
      context.read<GetCartCubit>().getCart(listToAdd);
      Commons().snackbarSuccess(context, itemAdded);
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
    return BlocProvider(
      create: (context) => GetCartCubit()..getCart([]),
      child: Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(space8)),
                  child: Image.network(
                    widget.image!,
                    fit: BoxFit.fill,
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
                      MathHelper().oCcy.format(widget.prices),
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
                BlocConsumer<GetCartCubit, GetCartState>(
                  builder: (context, state) => state is LoadingGetCart
                      ? LoadingButton(
                          color: systemPrimaryColor,
                          height: space56,
                        )
                      : GeneralButton.text(
                          widget.stocks == 0 ? outOfStock : addToCart,
                          padding:
                              const EdgeInsets.symmetric(vertical: space12),
                          buttonSize: ButtonSize.large,
                          backgroundColor: widget.stocks == 0
                              ? systemRedColor
                              : systemPrimaryColor,
                          width: double.infinity,
                          circular: space12,
                          onPressed: () {
                            if (widget.stocks! > 0) {
                              onClickedCart(
                                context,
                                [
                                  {
                                    "id": widget.id,
                                    "name": widget.name,
                                    "prices": widget.prices,
                                    "stocks": 1,
                                    "image": widget.image,
                                  }
                                ],
                              );
                            }
                          },
                        ),
                  listener: (context, state) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
