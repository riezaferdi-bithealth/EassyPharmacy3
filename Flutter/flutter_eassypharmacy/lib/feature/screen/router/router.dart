import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'package:flutter_eassypharmacy/feature/screen/home/list_order.dart';

class RoutingPage extends StatefulWidget {
  final bool? isResize;
  const RoutingPage({this.isResize, super.key});

  @override
  State<RoutingPage> createState() => _RoutingPageState();
}

class _RoutingPageState extends State<RoutingPage> {
  List<Widget> screens = [
    const HomePage(),
    const ListOrder(),
    const Profile(),
  ];

  String? isLogin;

  _stateToken() async {
    isLogin = await AccountHelper.getAuthToken();
    setState(() {});
  }

  onClicked(int index, BuildContext context) {
    if (index == 0) {
      setState(() {
        tabIndex.value = index;
      });
    } else {
      if (isLogin != null) {
        setState(() {
          tabIndex.value = index;
        });
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LoginOrRegisterPage();
            },
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _stateToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.isResize,
      body: screens.elementAt(tabIndex.value),
      bottomNavigationBar: BottomBar(
        selectedIndex: tabIndex.value,
        onClicked: (value) {
          onClicked(value, context);
        },
      ),
    );
  }
}
