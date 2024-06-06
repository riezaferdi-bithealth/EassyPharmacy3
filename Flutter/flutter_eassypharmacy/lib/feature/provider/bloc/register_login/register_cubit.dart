import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../../main.dart';

part 'register_state.dart';

class GetRegisterCubit extends Cubit<GetRegisterState> {
  GetRegisterCubit() : super(InitialGetRegister());

  void getRegister(
    String? fullName,
    String? phoneNumber,
    String? password,
    String? email,
  ) async {
    try {
      emit(LoadingGetRegister());

      final result = await APIRequest.register.submitRegister(
        fullName,
        phoneNumber,
        password,
        email,
      );

      if (result!.message! != "success") {
        logger.d(result);
        emit(NotLoadedGetRegister(error: result.message!.toString()));
      } else if (result.status == true) {
        logger.d(result.value);
        emit(LoadedGetRegister());
      }
    } catch (_) {
      logger.d(_);
      emit(const NotLoadedGetRegister(error: '$systemError$unknown'));
    }
  }
}
