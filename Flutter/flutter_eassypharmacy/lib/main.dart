import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MainApp(),
//       // initialRoute: splashNav,
//       // routes: {
//       //   splashNav: (context) => const SplashPage(),
//       //   homeNav: (context) => const MainApp(),
//       // Add other routes for your app screens here
//       // },
//     ),
//   );
// }

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Widget> screens = [
    const HomePage(),
    const Profile(),
  ];
  // bool testLoggedIn = false;
  String? isLogin;

  _stateToken() async {
    isLogin = await AccountHelper.getAuthToken();
  }

  onClicked(int index) {
    _stateToken();

    if (index == 0) {
      setState(() {
        indexStart = index;
      });
    } else {
      if (isLogin != null) {
        setState(() {
          indexStart = index;
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit()..isHasToken(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationInitial) {
              return const SplashPage();
            } else if (state is Authenticated) {
              return initHome(true);
            } else {
              return initHome(false);
            }
          },
        ),
      ),
    );
  }

  Widget initHome(bool isResize) {
    return Scaffold(
      resizeToAvoidBottomInset: isResize,
      body: screens.elementAt(indexStart),
      bottomNavigationBar: BottomBar(
        selectedIndex: indexStart,
        onClicked: onClicked,
      ),
    );
  }
}
