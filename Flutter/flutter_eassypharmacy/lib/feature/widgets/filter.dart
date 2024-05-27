import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class FilterButton extends StatefulWidget {
  final TextEditingController? controller;
  const FilterButton({
    this.controller,
    super.key,
  });

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool isFilterOn = false;
  bool isSortByNameAsc = false;
  bool isSortByNameDesc = false;
  bool isSortByStockAsc = false;
  bool isSortByStockDesc = false;

  void showBottomSheetFilter(BuildContext contextMain) async {
    showModalBottomSheet(
      // isDismissible: false,
      // enableDrag: false,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: systemWhiteColor,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3.5,
          decoration: BoxDecoration(
            color: systemWhiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(space30),
              topRight: Radius.circular(space30),
            ),
          ),
          padding: const EdgeInsets.only(
            left: space20,
            right: space20,
            bottom: space20,
            top: space20,
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Wrap(
              children: <Widget>[
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: const Icon(
                      //     Assets.close,
                      //     size: space20,
                      //   ),
                      // ),
                      Text(
                        filter,
                        style: p16.semiBold,
                      ),
                    ],
                  ),
                ),
                const ColumnDivider(padding: space30),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  //divider: const ColumnDivider(padding: space18),
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              byName,
                              style: p16.semiBold,
                            ),
                            const ColumnDivider(padding: space8),
                            sortByName(context),
                          ],
                        ),
                        const RowDivider(padding: space16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              byStock,
                              style: p16.semiBold,
                            ),
                            const ColumnDivider(padding: space8),
                            sortByStock(context),
                          ],
                        )
                      ],
                    ),
                    const ColumnDivider(padding: space16),
                    GeneralButton.text(
                      apply,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      buttonSize: ButtonSize.large,
                      backgroundColor: systemPrimaryColor,
                      width: double.infinity,
                      circular: 8,
                      onPressed: () {
                        print(isSortByNameAsc);
                        print(isSortByNameDesc);
                        print(isSortByStockAsc);
                        print(isSortByStockDesc);
                        // context.read<FilterDataCubit>().setDataFilter();
                        // _setParamFilter(
                        //     listSpecialization: listSpecialization,
                        //     listDayCheckBox: listDayCheckBox,
                        //     listTimeCheckBox: listTimeCheckBox,
                        //     listSexCheckBox: listSexCheckBox,
                        //     listAppointmentCheckBox:
                        //         listAppointmentCheckBox,
                        //     listLanguageCheckBox: listLanguageCheckBox);
                        // stateSetterMain!(() {});
                        // _loadChat(isTyping: true, isRefresh: true);
                        // //_test();
                        if (isSortByNameAsc == true ||
                            isSortByNameDesc == true ||
                            isSortByStockAsc == true ||
                            isSortByStockDesc == true) {
                          isFilterOn = true;
                        } else {
                          isFilterOn = false;
                        }
                        setState(() {});
                        contextMain.read<GetListMedicinesCubit>().getListMedicines(
                            widget.controller!.text,
                            isSortByNameAsc,
                            isSortByNameDesc,
                            isSortByStockAsc,
                            isSortByStockDesc);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetListMedicinesCubit, GetListMedicinesState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            // if (isFilterOn == false) {
            // isFilterOn = true;
            showBottomSheetFilter(context);
            // } else {
            //   isFilterOn = false;
            // }
            // setState(() {});
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4.3,
            height: MediaQuery.of(context).size.height / 18,
            // padding: const EdgeInsets.only(right: space8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(space8),
              color: systemWhiteColor,
              // color:
              //     isFilterOn == true ? systemPrimary50Color : systemWhiteColor,
              border: Border.all(
                color: systemPrimaryColor,
                width: 1,
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(space8),
                child: Row(
                  children: [
                    Text(
                      filter,
                      style: p12.black.normal,
                    ),
                    const RowDivider(padding: space4),
                    const Icon(
                      Assets.filterOn,
                      color: Colors.black,
                      size: 20,
                    )
                  ],
                )
                // child: isFilterOn == true
                //     ? Row(
                //         children: [
                //           Text(
                //             filterOn,
                //             style: p12.black.normal,
                //           ),
                //           const RowDivider(padding: space4),
                //           const Icon(
                //             Assets.filterOn,
                //             color: Colors.black,
                //             size: 20,
                //           )
                //         ],
                //       )
                //     : Row(
                //         children: [
                //           Text(
                //             filterOff,
                //             style: p12.grey.normal,
                //           ),
                //           const RowDivider(padding: space4),
                //           const Icon(
                //             Assets.filterOff,
                //             color: Colors.black,
                //             size: 20,
                //           )
                //         ],
                //       ),
                ),
          ),
        );
      },
      listener: (context, state) async {},
    );
  }

  Widget sortByName(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                if (isSortByNameAsc == false) {
                  isSortByNameAsc = true;
                  isSortByNameDesc = false;
                  isFilterOn = true;
                } else {
                  isSortByNameAsc = false;
                  isSortByNameDesc = false;
                  isFilterOn = false;
                }
                setState(() {});
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 18,
                // padding: const EdgeInsets.only(right: space8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(space8),
                  color: isSortByNameAsc == true
                      ? systemPrimary50Color
                      : systemWhiteColor,
                  border: Border.all(
                    color: systemPrimaryColor,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(space8),
                  child: Row(
                    children: [
                      Text(
                        aZ,
                        style: p12.black.normal,
                      ),
                      const RowDivider(padding: space4),
                      const Icon(
                        Assets.ascFilter,
                        color: Colors.black,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const RowDivider(padding: space8),
            GestureDetector(
              onTap: () {
                if (isSortByNameDesc == false) {
                  isSortByNameDesc = true;
                  isSortByNameAsc = false;
                  isFilterOn = true;
                } else {
                  isSortByNameAsc = false;
                  isSortByNameDesc = false;
                  isFilterOn = false;
                }
                setState(() {});
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 18,
                // padding: const EdgeInsets.only(right: space8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(space8),
                  color: isSortByNameDesc == true
                      ? systemPrimary50Color
                      : systemWhiteColor,
                  border: Border.all(
                    color: systemPrimaryColor,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(space8),
                  child: Row(
                    children: [
                      Text(
                        zA,
                        style: p12.black.normal,
                      ),
                      const RowDivider(padding: space4),
                      const Icon(
                        Assets.descFilter,
                        color: Colors.black,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget sortByStock(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                if (isSortByStockAsc == false) {
                  isSortByStockAsc = true;
                  isSortByStockDesc = false;
                  isFilterOn = true;
                } else {
                  isSortByStockAsc = false;
                  isSortByStockDesc = false;
                  isFilterOn = false;
                }
                setState(() {});
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 18,
                // padding: const EdgeInsets.only(right: space8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(space8),
                  color: isSortByStockAsc == true
                      ? systemPrimary50Color
                      : systemWhiteColor,
                  border: Border.all(
                    color: systemPrimaryColor,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(space8),
                  child: Row(
                    children: [
                      Text(
                        oneHundred,
                        style: p12.black.normal,
                      ),
                      const RowDivider(padding: space4),
                      const Icon(
                        Assets.ascFilter,
                        color: Colors.black,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const RowDivider(padding: space8),
            GestureDetector(
              onTap: () {
                if (isSortByStockDesc == false) {
                  isSortByStockDesc = true;
                  isSortByStockAsc = false;
                  isFilterOn = true;
                } else {
                  isSortByStockAsc = false;
                  isSortByStockDesc = false;
                  isFilterOn = false;
                }
                setState(() {});
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 18,
                // padding: const EdgeInsets.only(right: space8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(space8),
                  color: isSortByStockDesc == true
                      ? systemPrimary50Color
                      : systemWhiteColor,
                  border: Border.all(
                    color: systemPrimaryColor,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(space8),
                  child: Row(
                    children: [
                      Text(
                        hundredOne,
                        style: p12.black.normal,
                      ),
                      const RowDivider(padding: space4),
                      const Icon(
                        Assets.descFilter,
                        color: Colors.black,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
