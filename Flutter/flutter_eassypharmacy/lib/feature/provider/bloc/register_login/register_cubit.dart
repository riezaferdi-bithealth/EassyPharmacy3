import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../../main.dart';

part 'register_state.dart';

class GetRegisterCubit extends Cubit<GetRegisterState> {
  GetRegisterCubit() : super(InitialGetRegister());

  void getRegister(
    String? fullName,
    String? password,
    String? phoneNumber,
    String? email,
  ) async {
    try {
      // print("masuk try");
      emit(LoadingGetRegister());
      // print("mau masuk result");
      final result = await APIRequest.register.submitRegister(
        fullName,
        password,
        phoneNumber,
        email,
      );
      // print("mau logger ");
      logger.d(result!.value!);
      // print("mau masuk ");
      if (result.status == true) {
        logger.d(result.value);
        emit(LoadedGetRegister());
        // print("selesai IF");
      } else {
        logger.d(result);
        emit(NotLoadedGetRegister(error: result.message!.toString()));
      }
    } catch (_) {
      // print("Masuk catch");
      logger.d(_);
      emit(const NotLoadedGetRegister(error: '$systemError$unknown'));
    }
  }
}
