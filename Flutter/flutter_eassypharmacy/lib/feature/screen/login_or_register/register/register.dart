import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

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

    Commons().snackbarSuccess(context, "Register Successful");
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(space16),
            child: topBarSection(),
          ),
          bottomBarSection(context),
        ],
      ),
    );
  }

  Widget topBarSection() {
    return Column(
      children: [
        const ColumnDivider(padding: topBarPadding),
        const Text(register),
        const ColumnDivider(padding: space8),
        const Text(registerMessage),
        const ColumnDivider(padding: space16),
        formInput(
          name,
          nameMessage,
          nameController,
        ),
        const ColumnDivider(padding: space16),
        formInput(
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
        GestureDetector(
          onTap: () {
            _submitRegister(context);
          },
          child: Container(
            color: systemGreyColor,
            padding: const EdgeInsets.all(space8),
            child: const Text(createAccount),
          ),
        ),
        const ColumnDivider(padding: space8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              registerBottomMessageOne,
              style: p12.primary,
            ),
            Text(
              registerBottomMessageTwo,
              style: p12.primary.bold,
            ),
          ],
        ),
        const ColumnDivider(padding: space16),
      ],
    );
  }

  Widget formInput(
    String id,
    String? message,
    TextEditingController? controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(id),
        const ColumnDivider(padding: space8),
        TextFormField(
          // validator: _validatorForm,
          // initialValue: "tes",
          controller: controller,
          // style: p14.black,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            //fillColor: systemAccent20Color,
            //hoverColor: systemWhiteColor,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(space12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: systemPrimaryColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(space12)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: systemGreyColor,
                  width: 0.7,
                ),
                borderRadius: BorderRadius.circular(space12)),
            // hintStyle: p14.grey,
            hintText: message,
            isDense: true,
            // contentPadding: paddingTextField,
            // errorText: "Value Can't Be Empty",
          ),
        ),
      ],
    );
  }
}
