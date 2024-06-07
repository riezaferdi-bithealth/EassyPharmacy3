part of 'remove_cart_cubit.dart';

abstract class RemoveCartState extends Equatable {
  const RemoveCartState();

  @override
  List<Object> get props => [];
}

class InitialRemoveCart extends RemoveCartState {}

class LoadingRemoveCart extends RemoveCartState {}

class LoadedRemoveCart extends RemoveCartState {
  final CartModel listData;
  const LoadedRemoveCart({required this.listData});

  @override
  List<Object> get props => [listData];
}

class NotLoadedRemoveCart extends RemoveCartState {
  final String error;
  const NotLoadedRemoveCart({required this.error});

  @override
  List<Object> get props => [error];
}
