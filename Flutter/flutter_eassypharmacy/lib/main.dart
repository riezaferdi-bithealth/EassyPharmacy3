import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'package:logger/logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  application.flavor =
      flavorDev; //flavorDev; ; //flavorBeta; //flavorProduction
  runApp(const MainApp());
}

var logger = Logger(
  filter: null, // Use the default LogFilter (-> only log in debug mode)
  printer: PrettyPrinter(methodCount: 0),
  output: null, // Use the default LogOutput (-> send everything to console)
);

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

  String? isLogin;

  _stateToken() async {
    isLogin = await AccountHelper.getAuthToken();
  }

  onClicked(int index, BuildContext context) {
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
              return initHome(true, context);
            } else {
              return initHome(false, context);
            }
          },
        ),
      ),
    );
  }

  Widget initHome(bool isResize, BuildContext innerContext) {
    return Scaffold(
      resizeToAvoidBottomInset: isResize,
      body: screens.elementAt(indexStart),
      bottomNavigationBar: BottomBar(
        selectedIndex: indexStart,
        onClicked: (value) {
          onClicked(value, innerContext);
        },
      ),
    );
  }
}
