
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
}