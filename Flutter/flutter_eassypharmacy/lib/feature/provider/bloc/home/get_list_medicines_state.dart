part of 'get_list_medicines_cubit.dart';

abstract class GetListMedicinesState extends Equatable {
  const GetListMedicinesState();

  @override
  List<Object> get props => [];
}

class InitialGetListMedicines extends GetListMedicinesState {}

class LoadingGetListMedicines extends GetListMedicinesState {}

class LoadedGetListMedicines extends GetListMedicinesState {
  final GetListMedicines listData;
  const LoadedGetListMedicines({required this.listData});

  @override
  List<Object> get props => [listData];
}

class NotLoadedGetListMedicines extends GetListMedicinesState {
  final String error;
  const NotLoadedGetListMedicines({required this.error});

  @override
  List<Object> get props => [error];
}
