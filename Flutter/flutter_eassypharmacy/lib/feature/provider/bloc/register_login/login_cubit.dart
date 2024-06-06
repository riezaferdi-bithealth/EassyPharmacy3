import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../../main.dart';
part 'login_state.dart';

class GetLoginCubit extends Cubit<GetLoginState> {
  final AuthenticationCubit authenticationCubit;

  GetLoginCubit(this.authenticationCubit) : super(InitialGetLogin());

  void getLogin(
    String? email,
    String? password,
  ) async {
    try {
      emit(LoadingGetLogin());
      final result = await APIRequest.login.submitLogin(
        email,
        password,
      );

      if (result!.message != "success") {
        logger.d(result);
        emit(NotLoadedGetLogin(error: result.message!.toString()));
      } else if (result.status! == true) {
        logger.d(result.value!);
        authenticationCubit.loggedInFromLogin(result.value!);
        emit(LoadedGetLogin());
      }
    } catch (_) {
      logger.d(_);
      emit(const NotLoadedGetLogin(error: '$systemError$unknown'));
    }
  }
}
