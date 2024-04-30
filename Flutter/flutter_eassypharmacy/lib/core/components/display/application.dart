import 'package:flutter_eassypharmacy/feature/features.dart';

class Application {
  static final Application _application = Application._internal();
  FlavorConfig? flavor;

  factory Application() {
    return _application;
  }

  Application._internal();
}

Application application = Application();