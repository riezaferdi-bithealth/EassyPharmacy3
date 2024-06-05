import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../../main.dart';

part 'remove_cart_state.dart';

class RemoveCartCubit extends Cubit<RemoveCartState> {
  RemoveCartCubit() : super(InitialRemoveCart());

  void removeCart(List<dynamic>? listItems) async {
    try {
      final idUser = await AccountHelper.getUserId();

      emit(LoadingRemoveCart());

      final result = await APIRequest.cart.removeCart(
        int.parse(idUser ?? '0'),
        listItems,
      );

      logger.d(result!.value!);

      if (result.status == true) {
        logger.d(result.value);
      } else {
        logger.d(result);
        emit(NotLoadedRemoveCart(error: result.message!.toString()));
      }
    } catch (_) {
      logger.d(_);
      emit(const NotLoadedRemoveCart(error: '$systemError$unknown'));
    }
  }
}
