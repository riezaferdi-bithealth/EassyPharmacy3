part of 'get_cart_cubit.dart';

abstract class GetCartState extends Equatable {
  const GetCartState();

  @override
  List<Object> get props => [];
}

class InitialGetCart extends GetCartState {}

class LoadingGetCart extends GetCartState {}

class LoadedGetCart extends GetCartState {
  final CartModel listData;
  const LoadedGetCart({required this.listData});

  @override
  List<Object> get props => [listData];
}

class NotLoadedGetCart extends GetCartState {
  final String error;
  const NotLoadedGetCart({required this.error});

  @override
  List<Object> get props => [error];
}
