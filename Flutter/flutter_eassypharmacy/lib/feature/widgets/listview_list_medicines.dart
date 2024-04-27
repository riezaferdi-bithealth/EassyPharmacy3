import 'package:flutter/material.dart';
import 'package:flutter_eassypharmacy/core/core.dart';

import '../screen/home/detail_page.dart';

// FIXME NOT PROPERLY CLEAN CODE
// TODO MAKE PROPER UI LISTVIEW
class ListViewListMedicines extends StatelessWidget {
  const ListViewListMedicines({super.key});

  @override
  Widget build(BuildContext context) {
    //make container for list of medicines
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listMedicinePharm.length,
          itemBuilder: (context, index) {
            var items = listMedicinePharm[index];
            var stocks = stockMedicines[index];
            return GestureDetector(
              onTap: () {
                // if (snapshot.hasData) {
                //   newsProviders.selectArticles(
                //     data![index],
                //   );
                // }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailPage(),
                  ),
                );
              },
              child: Container(
                color: Colors.grey,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        // data![index].title ?? '_',
                        items,
                        style: p20.black.semiBold,
                        maxLines: 2,
                      ),
                      subtitle: Text(
                        // "Stock: ${data[index].source ?? '_'}",
                        "Stock: $stocks",
                        style: p12.white.normal,
                      ),
                      leading: Container(
                        width: 70,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              "https://picsum.photos/250?image=$index",
                              // data[index].urlToImage ??
                              //     'https://istow.id/wp-content/themes/trix/assets/images/no-image/No-Image-Found-400x264.png',
                            ),
                          ),
                        ),
                      ),
                      // trailing: Text(
                      //   "${data[index].author ?? '_'}",
                      //   style: const TextStyle(
                      //     fontSize: 12,
                      //     color: Colors.white,
                      //   ),
                      //   maxLines: 2,
                      // ),
                    ),
                    Container(
                      height: 10,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
