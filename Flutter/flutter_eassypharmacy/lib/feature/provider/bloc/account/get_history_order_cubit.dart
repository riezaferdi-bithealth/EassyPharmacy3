import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../../main.dart';

part 'get_history_order_state.dart';

class GetHistoryOrderCubit extends Cubit<GetHistoryOrderState> {
  GetHistoryOrderCubit() : super(InitialGetHistoryOrder());

  void getHistoryOrder() async {
    try {
      // print("masuk try");
      emit(LoadingGetHistoryOrder());
      // print("mau masuk result");
      final result = await APIRequest.cart.getHistoryOrder();
      // print("mau logger ");
      logger.d(result!.value!);
      // print("mau masuk ");
      if (result.status == true) {
        logger.d(result.value);
        emit(LoadedGetHistoryOrder(listData: result.value!.data!));
        // print("selesai IF");
      } else {
        logger.d(result);
        emit(NotLoadedGetHistoryOrder(error: result.message!.toString()));
      }
    } catch (_) {
      // print("Masuk catch");
      logger.d(_);
      emit(const NotLoadedGetHistoryOrder(error: '$systemError$unknown'));
    }
  }
}
