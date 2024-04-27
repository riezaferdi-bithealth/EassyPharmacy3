import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  void isHasToken() async {
    try {
      final String? userToken = await AccountHelper.getAuthToken();
      await Future.delayed(Duration(seconds: 3));
      if (userToken != null) {
        emit(Authenticated());
      } else {
        emit(NotAuthenticated());
      }
    } catch (_) {
      emit(NotAuthenticated());
    }
  }


  // Future<void> loggedIn(LoginModel loginModel) async {
  //   // await AccountHelper.saveUserInfo(loginModel);
  //
  //   emit(Authenticated());
  // }

  // Future<void> loggedInRegister(VerifyOtpModel registerModel) async {
  //   print("MASUK LOGGEDINREGISTER");
  //   await AccountHelper.saveUserInfoRegister(registerModel);
  //   print("MASUK SAVEUSERINFOREGISTER");
  //   emit(Authenticated());
  //   print("MASUK AUTHENTICATED");
  // }

  // // Future<void> loggedInFromLogin(VerifyOtpModel loginModel) async {
  // //   await AccountHelper.saveUserInfoFromLogin(loginModel);
  // //   print("MASUK LOGGEDINREGISTER");
  // //   await AccountHelper.saveUserInfoRegister(loginModel);
  // //   print("MASUK SAVEUSERINFOREGISTER");
  // //   emit(Authenticated());
  // //   print("MASUK AUTHENTICATED");
  // // }

  // Future<void> loggedInProfile(PatientData profilePatient) async {
  //   // print("MASUK loggedinprofile");
  //   await AccountHelper.saveUserProfile(profilePatient);
  //   // print("MASUK saveuserprofile");
  //   emit(Authenticated());
  //   // print("MASUK AUTHENTICATED");
  // }

  // Future<void> logout() async {


  //   final result = await APIRequest.user.logoutUser();

  //   if (result!.value!.code == 200) {
  //     await AccountHelper.removeUserInfo();
  //     emit(NotAuthenticated());
  //   } else {
  //     await AccountHelper.removeUserInfo();
  //     emit(NotAuthenticated());
  //   }
  // }


  // Future<void> logoutWithoutHitApi() async {

  //   await AccountHelper.removeUserInfo();
  //   tabIndex.value = 0;
  //   emit(NotAuthenticated());
  // }
}