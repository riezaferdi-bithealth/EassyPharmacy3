import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'package:flutter_eassypharmacy/feature/screen/login_or_register/register/register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _submitLogin(BuildContext context) async {
    if (emailController.text.isEmpty) {
      Commons().snackbarError(context, emailNeed);
      return;
    }
    if (!_validateEmail(emailController.text)) {
      Commons().snackbarError(context, emailNotValid);
      return;
    }
    if (passwordController.text.isEmpty) {
      Commons().snackbarError(context, passwordNeed);
      return;
    }

    context.read<GetLoginCubit>().getLogin(
          emailController.text,
          passwordController.text,
        );
  }

  bool _validateEmail(String value) {
    Pattern pattern = emailRegexPattern;
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetLoginCubit(AuthenticationCubit()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: systemPrimaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(
            space16,
            space16,
            space16,
            space8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              topBarSection(),
              bottomBarSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget topBarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ColumnDivider(padding: topBarPadding),
        Text(login, style: p28.primary.bold),
        const ColumnDivider(padding: space8),
        Text(loginMessage, style: p18.primary.medium),
        const ColumnDivider(padding: space24),
        FormInput().text(
          email,
          emailMessage,
          emailController,
        ),
        const ColumnDivider(padding: space16),
        FormInputPassword(
          id: password,
          message: passwordMessage,
          controller: passwordController,
        ),
        // const ColumnDivider(padding: space8),
        // Text(passwordRequirements, style: p12.primary.normal),
        // Center(child: Text("Or Login Using Phone Number"),),
      ],
    );
  }

  Widget bottomBarSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocConsumer<GetLoginCubit, GetLoginState>(
          listener: (context, state) {
            if (state is NotLoadedGetLogin) {
              Commons().snackbarError(context, state.error);
            } else if (state is LoadedGetLogin) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const RoutingPage(isResize: true),
                ),
                (route) => false,
              );

              Commons().snackbarSuccess(context, loginSuccessful);
              return;
            }
          },
          builder: (context, state) => state is LoadingGetLogin
              ? LoadingButton(
                  color: systemPrimaryColor,
                  height: space56,
                )
              : GeneralButton.text(
                  login,
                  padding: const EdgeInsets.symmetric(vertical: space12),
                  buttonSize: ButtonSize.large,
                  backgroundColor: systemPrimaryColor,
                  width: double.infinity,
                  height: 56,
                  circular: space12,
                  onPressed: () {
                    _submitLogin(context);
                  },
                ),
        ),
        const ColumnDivider(padding: space8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loginBottomMessageOne,
              style: p12.primary,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RegisterPage();
                }));
              },
              child: Text(
                loginBottomMessageTwo,
                style: p12.primary.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
