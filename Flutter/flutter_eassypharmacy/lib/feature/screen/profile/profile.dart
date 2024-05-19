import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'package:flutter_eassypharmacy/feature/screen/profile/blank.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userToken;
  String? userId;

  getToken() async {
    userToken = await AccountHelper.getAuthToken();
    userId = await AccountHelper.getUserId();
    setState(() {});
    // print(userToken);
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
        padding: const EdgeInsets.all(space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            const ColumnDivider(padding: topBarPadding),
            Text(
              "Hello, $userId",
              style: p30.primary.bold,
            ),
            rowLineProfileDivider(),
            profileSection(
              const Blank(),
              Assets.profileDetailIcon,
              systemPrimaryColor,
              profileDetail,
              p24.primary.medium,
            ),
            rowLineProfileDivider(),
            profileSection(
              const Blank(),
              Assets.listOrderIcon,
              systemPrimaryColor,
              listOrder,
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
