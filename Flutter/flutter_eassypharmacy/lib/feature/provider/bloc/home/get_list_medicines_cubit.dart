import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

part 'get_list_medicines_state.dart';

class GetListMedicinesCubit extends Cubit<GetListMedicinesState> {
  GetListMedicinesCubit() : super(InitialGetListMedicines());

  void getListMedicines() async {
    try {
      // print("masuk try");
      emit(LoadingGetListMedicines());
      // print("mau masuk result");
      final result = await APIRequest.home.getListMedicines();
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
