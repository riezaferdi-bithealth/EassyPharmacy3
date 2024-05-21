import '../../../../core/core.dart';
import '../../../../main.dart';
import '../../../features.dart';

part 'get_list_medicines_state.dart';

class GetListMedicinesCubit extends Cubit<GetListMedicinesState> {
  GetListMedicinesCubit() : super(InitialGetListMedicines());

  void getListMedicines(String? searchKey) async {
    try {
      // print("masuk try");
      emit(LoadingGetListMedicines());
      // print("mau masuk result");
      final result = await APIRequest.home.getListMedicines(searchKey);
      // print("mau logger ");
      logger.d(result!.value!);
      // print("mau masuk ");
      if (result.status == true) {
        logger.d(result.value);
        emit(LoadedGetListMedicines(listData: result.value!));
        // print("selesai IF");
      } else {
        logger.d(result);
        emit(NotLoadedGetListMedicines(error: result.message!.toString()));
      }
    } catch (_) {
      // print("Masuk catch");
      logger.d(_);
      emit(const NotLoadedGetListMedicines(error: '$systemError$unknown'));
    }
  }
}
