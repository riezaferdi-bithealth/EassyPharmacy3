import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  void isHasToken() async {
    try {
      final String? userToken = await AccountHelper.getAuthToken();
      await Future.delayed(const Duration(seconds: splashTimer));
      if (userToken != null) {
        emit(Authenticated());
      } else {
        emit(NotAuthenticated());
      }
    } catch (_) {
      emit(NotAuthenticated());
    }
  }

  Future<void> loggedInFromLogin(LoginModel loginModel) async {
    await AccountHelper.saveUserInfoFromLogin(loginModel);
    print("MASUK LOGGEDINREGISTER");
    // await AccountHelper.saveUserInfoRegister(loginModel);
    // print("MASUK SAVEUSERINFOREGISTER");
    emit(Authenticated());
    print("MASUK AUTHENTICATED");
  }
}
