import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class SearchTopBar extends StatefulWidget {
  final TextEditingController? controller;
  const SearchTopBar({
    this.controller,
    super.key,
  });

  @override
  State<SearchTopBar> createState() => _SearchTopBarState();
}

class _SearchTopBarState extends State<SearchTopBar> {
  String query = '';

  void _initListMedicinesData(BuildContext context, String searchInput) async {
    context.read<GetListMedicinesCubit>().getListMedicines(
          searchInput,
          false,
          false,
          false,
          false,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetListMedicinesCubit, GetListMedicinesState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 0, left: 16.0, right: 16.0),
          child: Form(
            child: TextFormField(
              // validator: _validatorForm,
              onChanged: (value) {
                setState(() {
                  query = value;
                  _initListMedicinesData(context, value);
                });
              },
              controller: widget.controller,
              style: p14.black.normal,
              decoration: InputDecoration(
                //fillColor: systemAccent20Color,
                //hoverColor: systemWhiteColor,
                // prefixIcon: Icon(Icons.search),
                suffixIcon: Assets.search,
                filled: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: systemPrimaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(6)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: systemGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(6)),
                hintStyle: p14.black.normal,
                hintText: search,
                isDense: true,
                // contentPadding: ,
                // errorText: "Value Can't Be Empty",
              ),
            ),
          ),
        );
      },
      listener: (context, state) async {},
    );
  }
}
