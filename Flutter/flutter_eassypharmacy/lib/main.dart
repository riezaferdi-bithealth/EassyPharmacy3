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

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
              return const RoutingPage(isResize: true);
            } else {
              return const RoutingPage(isResize: false);
            }
          },
        ),
      ),
    );
  }
}
