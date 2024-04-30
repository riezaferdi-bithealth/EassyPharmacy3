import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'package:flutter_eassypharmacy/feature/screen/login_or_register/login/login.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _submitRegister(BuildContext context) async {
    if (nameController.text.isEmpty) {
      Commons().snackbarError(context, fullNameNeed);
      return;
    }
    if (nameController.text.isNotEmpty) {
      if (nameController.text.length > 60) {
        Commons().snackbarError(context, nameLength);
        return;
      }
    }
    if (emailController.text.isEmpty) {
      Commons().snackbarError(context, emailNeed);
      return;
    }
    if (!_validateEmail(emailController.text)) {
      Commons().snackbarError(context, emailNotValid);
      return;
    }
    if (phoneController.text.isEmpty) {
      Commons().snackbarError(context, phoneNeed);
      return;
    }
    if (phoneController.text.isNotEmpty) {
      if (phoneController.text.length > 15) {
        Commons().snackbarError(context, phoneLength);
        return;
      }
    }
    if (passwordController.text.isEmpty) {
      Commons().snackbarError(context, passwordNeed);
      return;
    }
    if (!_validatePassword(passwordController.text)) {
      Commons().snackbarError(context, passwordNotValid);
      return;
    }

    Commons().snackbarSuccess(context, "Register Successful");
    return;
  }

  bool _validateEmail(String value) {
    Pattern pattern = emailRegexPattern;
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(value);
  }

  bool _validatePassword(String value) {
    Pattern pattern = passwordRegexPattern;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: topBarSection()),
          bottomBarSection(context),
        ],
      ),
    );
  }

  Widget topBarSection() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ColumnDivider(padding: space8),
          Text(register, style: p28.primary.bold),
          const ColumnDivider(padding: space8),
          Text(registerMessage, style: p18.primary.medium),
          const ColumnDivider(padding: space24),
          FormInput().text(
            name,
            nameMessage,
            nameController,
          ),
          const ColumnDivider(padding: space16),
          FormInput().text(
            email,
            emailMessage,
            emailController,
          ),
          const ColumnDivider(padding: space16),
          FormInput().phone(
            phone,
            phoneMessage,
            phoneController,
          ),
          const ColumnDivider(padding: space16),
          FormInputPassword(
            id: password,
            message: passwordMessage,
            controller: passwordController,
          ),
          const ColumnDivider(padding: space8),
          Text(passwordRequirements, style: p12.primary.normal),
        ],
      ),
    );
  }

  Widget bottomBarSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(space16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GeneralButton.text(
            createAccount,
            padding: const EdgeInsets.symmetric(vertical: space12),
            buttonSize: ButtonSize.large,
            backgroundColor: systemPrimaryColor,
            width: double.infinity,
            height: 56,
            circular: space12,
            onPressed: () {
              _submitRegister(context);
            },
          ),
          const ColumnDivider(padding: space8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                registerBottomMessageOne,
                style: p12.primary,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                },
                child: Text(
                  registerBottomMessageTwo,
                  style: p12.primary.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
