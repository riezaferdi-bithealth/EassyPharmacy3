import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

part 'login_state.dart';

class GetLoginCubit extends Cubit<GetLoginState> {
  final AuthenticationCubit authenticationCubit;
  GetLoginCubit(this.authenticationCubit) : super(InitialGetLogin());

  void getLogin(
    // String? phoneNumber,
    String? email,
    String? password,
  ) async {
    try {
      // print("masuk try");
      emit(LoadingGetLogin());
      // print("mau masuk result");
      final result = await APIRequest.login.submitLogin(
        // phoneNumber,
        email,
        password,
      );
      // print("mau logger ");
      logger.d(result!.value!);
      // print("mau masuk ");
      if (result.status == true) {
        logger.d(result.value);
        authenticationCubit.loggedInFromLogin(result.value!);
        emit(LoadedGetLogin());
        // print("selesai IF");
      } else {
        logger.d(result);
        emit(NotLoadedGetLogin(error: result.message!.toString()));
      }
    } catch (_) {
      // print("Masuk catch");
      logger.d(_);
      emit(const NotLoadedGetLogin(error: '$systemError$unknown'));
    }
  }
}
