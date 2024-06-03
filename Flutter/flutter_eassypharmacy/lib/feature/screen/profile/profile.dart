import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'package:flutter_eassypharmacy/feature/screen/profile/account_details.dart';
import 'package:flutter_eassypharmacy/feature/screen/profile/history_orders.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userName;

  getToken() async {
    userName = await AccountHelper.getUserFullName();
    setState(() {});
  }

  String getFirstName(String fullName) {
    List<String> parts = fullName.trim().split(RegExp(r'\s+'));
    return parts.isNotEmpty ? parts[0] : '';
  }

  @override
  initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: systemPrimaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ColumnDivider(padding: space48),
            Icon(
              Assets.profileDetailIcon,
              color: systemWhiteColor,
              size: 125.0,
            ),
            const ColumnDivider(padding: space30),
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              padding: const EdgeInsets.all(space16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(space30),
                    topRight: Radius.circular(space30)),
                color: systemWhiteColor,
                // border: Border.all(
                //   color: systemPrimaryColor,
                //   width: 1,
                // ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  // const ColumnDivider(padding: space8),
                  Center(
                    child: Text(
                      "Hello, ${getFirstName(userName ?? '')}",
                      style: p30.primary.bold,
                    ),
                  ),
                  rowLineProfileDivider(),
                  profileSection(
                    const AccountDetails(),
                    Assets.profileDetailIcon,
                    systemPrimaryColor,
                    profileDetail,
                    p24.primary.medium,
                  ),
                  rowLineProfileDivider(),
                  profileSection(
                    const HistoryOrders(),
                    Assets.listOrderIcon,
                    systemPrimaryColor,
                    historyOrders,
                    p24.primary.medium,
                  ),
                  rowLineProfileDivider(),
                  profileSection(
                    const RoutingPage(isResize: false),
                    Assets.logoutIcon,
                    systemRedColor,
                    logout,
                    p24.red.medium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowLineProfileDivider() {
    return Column(
      children: [
        const ColumnDivider(padding: space8),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 200,
          color: systemPrimary50Color,
        ),
        const ColumnDivider(padding: space8),
      ],
    );
  }

  Widget profileSection(
    Widget routingPage,
    IconData icon,
    Color color,
    String id,
    TextStyle styleId,
  ) {
    return GestureDetector(
      onTap: () async {
        if (id == logout) {
          tabIndex.value = 0;
          await AccountHelper.removeUserInfo();

          if (!mounted) return;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => routingPage,
            ),
            (route) => false,
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => routingPage,
            ),
          );
        }
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: iconProfileSize,
          ),
          const RowDivider(padding: space16),
          Text(
            id,
            style: styleId,
          ),
        ],
      ),
    );
  }
}
