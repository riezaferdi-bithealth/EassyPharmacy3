part of 'login_cubit.dart';

abstract class GetLoginState extends Equatable {
  const GetLoginState();

  @override
  List<Object> get props => [];
}

class InitialGetLogin extends GetLoginState {}

class LoadingGetLogin extends GetLoginState {}

class LoadedGetLogin extends GetLoginState {
  // final LoginModel listData;
  // const LoadedGetLogin({required this.listData});

  @override
  List<Object> get props => [
        // listData,
      ];
}

class NotLoadedGetLogin extends GetLoginState {
  final String error;
  const NotLoadedGetLogin({required this.error});

  @override
  List<Object> get props => [error];
}
