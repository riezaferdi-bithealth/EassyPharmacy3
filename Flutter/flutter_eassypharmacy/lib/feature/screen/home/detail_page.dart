import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class DetailPage extends StatelessWidget {
  final int? id;
  const DetailPage({
    this.id,
    super.key,
  });

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(space8)),
              child: Image.network(
                "https://picsum.photos/250?image=$id",
                fit: BoxFit.fill,
                // scale: imageScaleListMedicine,
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 1.5,
              ),
            ),
            Text(
              listMedicinePharm[id!],
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
                  stockMedicines[id!].toString(),
                  style: p14.primary.normal,
                ),
              ],
            ),
            const ColumnDivider(padding: space4),
            Row(
              children: [
                Text(
                  price,
                  style: p14.primary.normal,
                ),
                Text(
                  "Rp 20.000,-",
                  style: p14.primary.normal,
                ),
              ],
            ),
            const ColumnDivider(padding: 50),
            GeneralButton.text(
              addToCart,
              padding: const EdgeInsets.symmetric(vertical: space12),
              buttonSize: ButtonSize.large,
              backgroundColor: systemPrimaryColor,
              width: double.infinity,
              // height: 56,
              circular: space12,
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return const Blank();
                // }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
