part of 'order_checkout_cubit.dart';

abstract class OrderCartState extends Equatable {
  const OrderCartState();

  @override
  List<Object> get props => [];
}

class InitialOrderCart extends OrderCartState {}

class LoadingOrderCart extends OrderCartState {}

class LoadedOrderCart extends OrderCartState {
  final CartModel listData;
  const LoadedOrderCart({required this.listData});

  @override
  List<Object> get props => [listData];
}

class NotLoadedOrderCart extends OrderCartState {
  final String error;
  const NotLoadedOrderCart({required this.error});

  @override
  List<Object> get props => [error];
}
