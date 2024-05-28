import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../../main.dart';

part 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  GetCartCubit() : super(InitialGetCart());

  void getCart(
    List<dynamic>? listItems
    // int? idItems,
    // String? nameItems,
    // int? priceItems,
  ) async {
    try {
      final idUser = await AccountHelper.getUserId();
      // print("masuk try");
      emit(LoadingGetCart());
      // print("mau masuk result");
      final result = await APIRequest.cart.saveCart(
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
        emit(LoadedGetCart(listData: result.value!));
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
}
