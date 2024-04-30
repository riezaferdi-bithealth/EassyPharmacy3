import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'package:flutter_eassypharmacy/feature/screen/home/detail_page.dart';

class GridViewListMedicines extends StatelessWidget {
  const GridViewListMedicines({super.key});

  @override
  Widget build(BuildContext context) {
    //make container for list of medicines
    return GridView.count(
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      childAspectRatio: ((MediaQuery.of(context).size.width / 2) /
          (MediaQuery.of(context).size.height / 3.4)),
      children: List.generate(listMedicinePharm.length, (index) {
        var items = listMedicinePharm[index];
        var stocks = stockMedicines[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailPage(id: index);
            }));
          },
          child: Container(
            margin: const EdgeInsets.all(space8),
            padding: const EdgeInsets.all(space8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(space8),
              color: systemPrimary50Color,
              border: Border.all(
                color: systemPrimaryColor,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(space8)),
                  child: Image.network(
                    "https://picsum.photos/250?image=$index",
                    fit: BoxFit.fill,
                    scale: imageScaleListMedicine,
                    // height: MediaQuery.of(context).size.height / 8,
                    // width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
                Text(
                  items,
                  style: p16.primary.normal,
                ),
                const ColumnDivider(padding: space4),
                Row(
                  children: [
                    Text(
                      stock,
                      style: p14.primary.normal,
                    ),
                    Text(
                      stocks.toString(),
                      style: p14.primary.normal,
                    ),
                  ],
                ),
                const ColumnDivider(padding: space4),
                GeneralButton.text(
                  addToCart,
                  padding: const EdgeInsets.symmetric(vertical: space12),
                  buttonSize: ButtonSize.small,
                  backgroundColor: systemPrimaryColor,
                  width: double.infinity,
                  // height: 56,
                  circular: space12,
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return const ListOrder();
                    // }));
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
