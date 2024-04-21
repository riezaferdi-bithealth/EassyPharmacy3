import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'package:flutter_eassypharmacy/feature/screen/login_or_register/register/register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();

  void _submitLogin(BuildContext context) async {
    if (emailController.text.isEmpty) {
      Commons().snackbarError(context, emailNeed);
      return;
    }
    if (!_validateEmail(emailController.text)) {
      Commons().snackbarError(context, emailNotValid);
      return;
    }

    Commons().snackbarSuccess(context, "Login Successful");
    return;
  }

  bool _validateEmail(String value) {
    Pattern pattern = emailRegexPattern;
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.all(space16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            topBarSection(),
            bottomBarSection(context),
          ],
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
      ],
    );
  }

  Widget bottomBarSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GeneralButton.text(
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
                  return RegisterPage();
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
