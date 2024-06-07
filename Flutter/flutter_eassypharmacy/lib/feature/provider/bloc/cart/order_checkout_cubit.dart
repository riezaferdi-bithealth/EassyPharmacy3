import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../../main.dart';

part 'order_checkout_state.dart';

class OrderCartCubit extends Cubit<OrderCartState> {
  OrderCartCubit() : super(InitialOrderCart());

  void orderCart(List<dynamic>? listItems) async {
    try {
      final idUser = await AccountHelper.getUserId();

      emit(LoadingOrderCart());

      final result = await APIRequest.cart.orderCart(
        int.parse(idUser ?? '0'),
        listItems,
      );

      logger.d(result!.value!);

      if (result.status == true) {
        logger.d(result.value);
        emit(LoadedOrderCart(listData: result.value!));
      } else {
        logger.d(result);
        emit(NotLoadedOrderCart(error: result.message!.toString()));
      }
    } catch (_) {
      logger.d(_);
      emit(const NotLoadedOrderCart(error: '$systemError$unknown'));
    }
  }
}
