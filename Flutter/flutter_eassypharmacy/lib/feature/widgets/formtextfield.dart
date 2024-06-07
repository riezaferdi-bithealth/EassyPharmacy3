import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class FormInput {
  Widget text(
    String id,
    String? message,
    TextEditingController? controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(id, style: p14.primary.medium),
        const ColumnDivider(padding: space8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: systemWhiteColor,
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
        Text(id, style: p14.primary.medium),
        const ColumnDivider(padding: space8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            fillColor: systemWhiteColor,
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
        Text(widget.id!, style: p14.primary.medium),
        const ColumnDivider(padding: space8),
        TextFormField(
          controller: widget.controller,
          obscureText: !_passwordVisible,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: systemWhiteColor,
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
                _passwordVisible ? Assets.passVisible : Assets.passNotVisible,
                color: systemBlackColor,
              ),
              onPressed: () async {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
