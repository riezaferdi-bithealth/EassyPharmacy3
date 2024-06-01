import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../../main.dart';

part 'remove_cart_state.dart';

class RemoveCartCubit extends Cubit<RemoveCartState> {
  RemoveCartCubit() : super(InitialRemoveCart());

  void removeCart(
    List<dynamic>? listItems
    // int? idItems,
    // String? nameItems,
    // int? priceItems,
  ) async {
    try {
      final idUser = await AccountHelper.getUserId();
      // print("masuk try");
      emit(LoadingRemoveCart());
      // print("mau masuk result");
      final result = await APIRequest.cart.removeCart(
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
        // emit(LoadedRemoveCart(listData: result.value!));
        // print("selesai IF");
      } else {
        logger.d(result);
        emit(NotLoadedRemoveCart(error: result.message!.toString()));
      }
    } catch (_) {
      // print("Masuk catch");
      logger.d(_);
      emit(const NotLoadedRemoveCart(error: '$systemError$unknown'));
    }
  }
}
