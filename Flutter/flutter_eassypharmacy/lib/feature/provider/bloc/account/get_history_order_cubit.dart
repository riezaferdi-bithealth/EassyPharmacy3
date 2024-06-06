import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../../main.dart';

part 'get_history_order_state.dart';

class GetHistoryOrderCubit extends Cubit<GetHistoryOrderState> {
  GetHistoryOrderCubit() : super(InitialGetHistoryOrder());

  void getHistoryOrder() async {
    try {
      emit(LoadingGetHistoryOrder());
      final result = await APIRequest.cart.getHistoryOrder();
      logger.d(result!.value!);
      if (result.status == true) {
        logger.d(result.value);
        emit(LoadedGetHistoryOrder(listData: result.value!.data!));
      } else {
        logger.d(result);
        emit(NotLoadedGetHistoryOrder(error: result.message!.toString()));
      }
    } catch (_) {
      logger.d(_);
      emit(const NotLoadedGetHistoryOrder(error: '$systemError$unknown'));
    }
  }
}
