import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/core.dart';

class SearchTopBar extends StatefulWidget {
  const SearchTopBar({super.key});

  @override
  State<SearchTopBar> createState() => _SearchTopBarState();
}

class _SearchTopBarState extends State<SearchTopBar> {
  String query = '';
  final TextEditingController _searchController = TextEditingController();

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0, left: 16.0, right: 16.0),
      child: Column(
        children: [
          Form(
            child: TextFormField(
              // validator: _validatorForm,
              onChanged: onQueryChanged,
              controller: _searchController,
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
          // _searchController.text.isNotEmpty
          //     ? listTileNewsMain(
          //         "",
          //         "",
          //         "",
          //         _searchController.text,
          //         "10",
          //       )
          //     : SizedBox.shrink(),
        ],
      ),
    );
  }
}