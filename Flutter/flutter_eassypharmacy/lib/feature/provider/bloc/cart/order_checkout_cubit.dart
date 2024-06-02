import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../../main.dart';

part 'order_checkout_state.dart';

class OrderCartCubit extends Cubit<OrderCartState> {
  OrderCartCubit() : super(InitialOrderCart());

  void orderCart(List<dynamic>? listItems
      // int? idItems,
      // String? nameItems,
      // int? priceItems,
      ) async {
    try {
      final idUser = await AccountHelper.getUserId();
      // print("masuk try");
      emit(LoadingOrderCart());
      // print("mau masuk result");
      final result = await APIRequest.cart.orderCart(
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
        emit(LoadedOrderCart(listData: result.value!));
        // print("selesai IF");
      } else {
        logger.d(result);
        emit(NotLoadedOrderCart(error: result.message!.toString()));
      }
    } catch (_) {
      // print("Masuk catch");
      logger.d(_);
      emit(const NotLoadedOrderCart(error: '$systemError$unknown'));
    }
  }
}
