part of 'get_history_order_cubit.dart';

abstract class GetHistoryOrderState extends Equatable {
  const GetHistoryOrderState();

  @override
  List<Object> get props => [];
}

class InitialGetHistoryOrder extends GetHistoryOrderState {}

class LoadingGetHistoryOrder extends GetHistoryOrderState {}

class LoadedGetHistoryOrder extends GetHistoryOrderState {
  final List<StructModel> listData;
  const LoadedGetHistoryOrder({required this.listData});

  @override
  List<Object> get props => [listData];
}

class NotLoadedGetHistoryOrder extends GetHistoryOrderState {
  final String error;
  const NotLoadedGetHistoryOrder({required this.error});

  @override
  List<Object> get props => [error];
}
