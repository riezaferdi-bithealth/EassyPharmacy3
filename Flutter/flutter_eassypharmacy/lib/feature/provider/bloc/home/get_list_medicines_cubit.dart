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
      emit(LoadingGetListMedicines());

      final result = await APIRequest.home.getListMedicines(searchKey);

      logger.d(result!.value!);

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
      } else {
        logger.d(result);
        emit(NotLoadedGetListMedicines(error: result.message!.toString()));
      }
    } catch (_) {
      logger.d(_);
      emit(const NotLoadedGetListMedicines(error: '$systemError$unknown'));
    }
  }

  void filterMedicinesByStock(List<ListMedicines> listItems, bool? available) {
    if (available == true) {
      listItems.removeWhere((element) => element.stock! == 0);
    } else {
      listItems.removeWhere((element) => element.stock! > 0);
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
}
