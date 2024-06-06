import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isViewTypeGrid = true;
  bool isFilterOn = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetListMedicinesCubit()
            ..getListMedicines(
              _searchController.text,
              false,
              false,
              false,
              false,
              false,
              false,
            ),
        ),
        BlocProvider(
          create: (context) => GetCartCubit()..getCart([]),
        )
      ],
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [
                0.7,
                1,
              ],
              colors: [
                systemWhiteColor,
                systemBlueShade200Color,
              ],
            ),
          ),
          child: Column(
            children: [
              const ColumnDivider(padding: topBarPadding),
              Text(
                eassyPharmacy,
                style: p30.primary.bold,
              ),
              Text(
                sloganStore,
                style: p16.primary.medium,
              ),
              const ColumnDivider(padding: space16),
              Row(
                children: [
                  Expanded(child: SearchTopBar(controller: _searchController)),
                  FilterButton(controller: _searchController),
                  const RowDivider(padding: space8),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (isViewTypeGrid == false) {
                          isViewTypeGrid = true;
                        } else {
                          isViewTypeGrid = false;
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.height / 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(space12),
                          color: systemPrimaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(space8),
                          child: Container(
                            color: systemPrimaryColor,
                            child: Row(
                              children: [
                                Icon(
                                  isViewTypeGrid == true
                                      ? Icons.grid_view_rounded
                                      : Icons.list_rounded,
                                  color: systemWhiteColor,
                                ),
                                const RowDivider(padding: space4),
                                Text(
                                  isViewTypeGrid == true ? gridView : listView,
                                  style: p12.white.medium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const ColumnDivider(padding: space8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: isViewTypeGrid == true
                        ? GridViewListMedicines(controller: _searchController)
                        : ListViewListMedicines(controller: _searchController),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
