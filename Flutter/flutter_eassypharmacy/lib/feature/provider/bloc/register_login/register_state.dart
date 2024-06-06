part of 'register_cubit.dart';

abstract class GetRegisterState extends Equatable {
  const GetRegisterState();

  @override
  List<Object> get props => [];
}

class InitialGetRegister extends GetRegisterState {}

class LoadingGetRegister extends GetRegisterState {}

class LoadedGetRegister extends GetRegisterState {
  @override
  List<Object> get props => [];
}

class NotLoadedGetRegister extends GetRegisterState {
  final String error;
  const NotLoadedGetRegister({required this.error});

  @override
  List<Object> get props => [error];
}
