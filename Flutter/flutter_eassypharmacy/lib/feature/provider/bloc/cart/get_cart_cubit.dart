import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../../main.dart';

part 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  GetCartCubit() : super(InitialGetCart());
  int totalPriceItems = 0;

  void getCart(List<dynamic>? listItems) async {
    try {
      final idUser = await AccountHelper.getUserId();

      emit(LoadingGetCart());

      final result = await APIRequest.cart.addCart(
        int.parse(idUser ?? '0'),
        listItems,
      );

      logger.d(result!.value!);

      if (result.status == true) {
        logger.d(result.value);
        var listItems = result.value!.data!;
        for (var item in listItems) {
          totalPriceItems += item.price!;
        }
        emit(LoadedGetCart(
          listData: listItems,
          totalPrice: totalPriceItems,
        ));
      } else {
        logger.d(result);
        emit(NotLoadedGetCart(error: result.message!.toString()));
      }
    } catch (_) {
      logger.d(_);
      emit(const NotLoadedGetCart(error: '$systemError$unknown'));
    }
  }

  void addQty(List<CartItems> newData, int idToAdd) async {
    final item = newData.map((element) {
      if (element.id == idToAdd) {
        totalPriceItems += element.price!;
        return element.copyWith(qtyNew: element.qty! + 1);
      } else {
        return element;
      }
    }).toList();
    emit(LoadedGetCart(
      listData: item,
      totalPrice: totalPriceItems,
    ));
  }

  void subsQty(List<CartItems> newData, int idToSubs) async {
    final item = newData.map((element) {
      if (element.id == idToSubs && element.qty! > 1) {
        totalPriceItems -= element.price!;
        return element.copyWith(qtyNew: element.qty! - 1);
      } else {
        return element;
      }
    }).toList();
    emit(LoadedGetCart(
      listData: item,
      totalPrice: totalPriceItems,
    ));
  }
}
