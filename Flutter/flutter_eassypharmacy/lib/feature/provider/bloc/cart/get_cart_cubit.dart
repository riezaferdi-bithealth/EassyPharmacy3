import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../../main.dart';

part 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  GetCartCubit() : super(InitialGetCart());
  int totalPriceItems = 0;

  void getCart(List<dynamic>? listItems
      // int? idItems,
      // String? nameItems,
      // int? priceItems,
      ) async {
    try {
      final idUser = await AccountHelper.getUserId();
      // print("masuk try");
      emit(LoadingGetCart());
      // print("mau masuk result");
      final result = await APIRequest.cart.addCart(
        int.parse(idUser ?? '0'),
        listItems,
        // idItems,
        // nameItems,
        // priceItems,
      );
      // print("mau logger ");
      logger.d(result!.value!);
      // print("mau masuk ");
      if (result.status == true) {
        logger.d(result.value);
        var listItems = result.value!.data!;
        totalPriceCart(listItems);
        emit(LoadedGetCart(
          listData: listItems,
          totalPrice: totalPriceItems,
        ));
        // print("selesai IF");
      } else {
        logger.d(result);
        emit(NotLoadedGetCart(error: result.message!.toString()));
      }
    } catch (_) {
      // print("Masuk catch");
      logger.d(_);
      emit(const NotLoadedGetCart(error: '$systemError$unknown'));
    }
  }

  void addQty(CartItems value) async {
    List<dynamic> data = [];
    final item = data.firstWhere((element) => element.id == value.id);
    item.setQty(item.stock! + 1);
  }

  void subsQty(CartItems value) async {
    List<dynamic> data = [];
    final item = data.firstWhere((element) => element.id == value.id);
    if (item.stock! > 1) {
      item.setQty(item.stock! - 1);
    }
  }

  int totalPriceCart(List<CartItems> listItems) {
    for (var item in listItems) {
      totalPriceItems += item.price! * item.qty!;
    }
    return totalPriceItems;
  }
}
