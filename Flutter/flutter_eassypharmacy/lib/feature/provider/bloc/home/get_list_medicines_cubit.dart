import '../../../../core/core.dart';
import '../../../../main.dart';
import '../../../features.dart';

part 'get_list_medicines_state.dart';

class GetListMedicinesCubit extends Cubit<GetListMedicinesState> {
  GetListMedicinesCubit() : super(InitialGetListMedicines());

  void getListMedicines(
    String? searchKey,
    bool? isFilterByStockAvail,
    bool? isFilterByStockUnavail,
    bool? filterNameAsc,
    bool? filterNameDesc,
    bool? filterStockAsc,
    bool? filterStockDesc,
  ) async {
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
        if (isFilterByStockAvail == true ||
            isFilterByStockUnavail == true ||
            filterNameAsc == true ||
            filterNameDesc == true ||
            filterStockAsc == true ||
            filterStockDesc == true) {
          var listItems = result.value!.data!;
          if (isFilterByStockAvail == true || isFilterByStockUnavail == true) {
            filterMedicinesByStock(listItems, isFilterByStockAvail);
          }
          if (filterNameAsc == true || filterNameDesc == true) {
            sortMedicinesByName(listItems, filterNameAsc);
          }
          if (filterStockAsc == true || filterStockDesc == true) {
            sortMedicinesByStock(listItems, filterStockAsc);
          }

          emit(LoadedGetListMedicines(listData: listItems));
        } else {
          emit(LoadedGetListMedicines(listData: result.value!.data!));
        }

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

  List<ListMedicines> filterMedicinesByStock(
      List<ListMedicines> listItems, bool? available) {
    if (available == true) {
      return listItems.where((medicine) => medicine.stock! > 0).toList();
    } else {
      return listItems.where((medicine) => medicine.stock == 0).toList();
    }
  }

  List<ListMedicines> sortMedicinesByName(
      List<ListMedicines> listItems, bool? ascending) {
    listItems.sort((a, b) {
      if (ascending == true) {
        return a.name!.compareTo(b.name!);
      } else {
        return b.name!.compareTo(a.name!);
      }
    });
    return listItems;
  }

  List<ListMedicines> sortMedicinesByStock(
      List<ListMedicines> listItems, bool? ascending) {
    listItems.sort((a, b) {
      if (ascending == true) {
        return a.stock!.compareTo(b.stock!);
      } else {
        return b.stock!.compareTo(a.stock!);
      }
    });
    return listItems;
  }

  // void addQty(CartItems value) async {
  //   List<CartItems> data = [];
  //   final item = data.firstWhere((element) => element.id == value.id);
  //   item.setQty(item.stock! + 1);
  // }

  // void subsQty(List<ListMedicines> medicine) async {
  //   final item = medicine.firstWhere((element) => element.id == medicine.id);
  //   if(item.stock! > 1){
  //     item.setQty(item.stock! - 1);
  //   }
  // }
}
