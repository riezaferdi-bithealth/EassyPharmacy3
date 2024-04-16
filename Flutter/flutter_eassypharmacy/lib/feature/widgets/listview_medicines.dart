import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

// FIXME NOT PROPERLY CLEAN CODE
// TODO MAKE PROPER UI LISTVIEW
class ListMedicines extends StatelessWidget {
  const ListMedicines({super.key});

  @override
  Widget build(BuildContext context) {
    //make container for list of medicines
    return GridView.count(
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(listMedicinePharm.length, (index) {
        var items = listMedicinePharm[index];
        var stocks = stockMedicines[index];
        return Container(
          color: Colors.grey[200],
          // height: MediaQuery.of(context).size.height / 2,
          // width: MediaQuery.of(context).size.width / 2,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                "https://picsum.photos/250?image=$index",
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width / 2,
              ),
              Text(items),
              Row(
                children: [
                  const Text(stock),
                  Text(stocks.toString()),
                ],
              ),
              // TODO MAKE CONTAINER FOR ADD TO CHART
              Container(
                color: Colors.grey[300],
                child: const Row(
                  children: [
                    Icon(Icons.add),
                    RowDivider(padding: 4),
                    Text(addToCart)
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
