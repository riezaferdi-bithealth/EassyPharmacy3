import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

// class Form extends StatelessWidget {
//   const Form({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class FormInput {
  Widget text(
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
            fillColor: systemPrimary50Color,
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
            hintStyle: p14.grey,
            hintText: message,
            isDense: true,
            // contentPadding: paddingTextField,
            // errorText: "Value Can't Be Empty",
          ),
        ),
      ],
    );
  }

  Widget phone(
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
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            fillColor: systemPrimary50Color,
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
            hintStyle: p14.grey,
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

class FormInputPassword extends StatefulWidget {
  final String? id;
  final String? message;
  final TextEditingController? controller;

  const FormInputPassword({
    this.id,
    this.message,
    this.controller,
    super.key,
  });

  @override
  State<FormInputPassword> createState() => _FormInputPasswordState();
}

class _FormInputPasswordState extends State<FormInputPassword> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.id!),
        const ColumnDivider(padding: space8),
        TextFormField(
          // validator: _validatorForm,
          // initialValue: "tes",
          controller: widget.controller,
          // style: p14.black,
          obscureText: !_passwordVisible,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: systemPrimary50Color,
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
            hintStyle: p14.grey,
            hintText: widget.message,
            isDense: true,
            suffixIcon: IconButton(
              icon: Icon(
                // Based on _passwordVisible state choose the icon
                _passwordVisible ? Assets.passVisible : Assets.passNotVisible,
                color: systemBlackColor,
              ),
              onPressed: () async {
                // Update the state i.e. toogle the state of _passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            // contentPadding: paddingTextField,
            // errorText: "Value Can't Be Empty",
          ),
        ),
      ],
    );
  }
}
