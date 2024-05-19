import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

import '../screen/home/detail_page.dart';

class ListViewCart extends StatefulWidget {
  final TextEditingController? controller;
  const ListViewCart({this.controller, super.key});

  @override
  State<ListViewCart> createState() => _ListViewCartState();
}

class _ListViewCartState extends State<ListViewCart> {
  String? isLogin;

  // void _initCartData() {
  //   context.read<GetCartCubit>().getCart(widget.controller!.text);
  // }

  _stateToken() async {
    isLogin = await AccountHelper.getAuthToken();
  }

  onClickedCart(BuildContext context) {
    _stateToken();

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
    // _initCartData();
    super.initState();
    _stateToken();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<GetCartCubit, GetCartState>(
    //   builder: (context, state) {
    //     if (state is LoadingGetCart) {
    //     } else if (state is NotLoadedGetCart) {
    //     } else if (state is LoadedGetCart) {
    //       //make container for list of medicines
    //       return state.listData.data!.isEmpty
    //           ? Text("SEARCH NOT FOUND")
    //           :
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        // var item = state.listData.data![index];
        return Container(
          color: systemPrimary50Color,
          margin: const EdgeInsets.fromLTRB(
            space16,
            space8,
            space16,
            space8,
          ),
          padding: const EdgeInsets.all(space8),
          child: Column(
            children: [
              ListTile(
                trailing: GeneralButton.text(
                  addToCart,
                  padding: const EdgeInsets.symmetric(vertical: space12),
                  buttonSize: ButtonSize.small,
                  backgroundColor: systemPrimaryColor,
                  width: MediaQuery.of(context).size.width / 4,
                  // height: 56,
                  circular: space12,
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return const ListOrder();
                    // }));
                  },
                ),
                title: Text(
                  "Paracetamol",
                  style: p16.black.semiBold,
                  maxLines: 2,
                ),
                subtitle: Text(
                  "100",
                  style: p12.primary.normal,
                ),
                // leading: Container(
                //   width: 70,
                //   height: 120,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     image: DecorationImage(
                //       fit: BoxFit.fill,
                //       image: NetworkImage(
                //         item.image!,
                //       ),
                //     ),
                //   ),
                // ),
              ),
            ],
          ),
        );
      },
    );
  }
  //       return const SizedBox.shrink();
  //     },
  //     listener: (context, state) async {},
  //   );
  // }
}
