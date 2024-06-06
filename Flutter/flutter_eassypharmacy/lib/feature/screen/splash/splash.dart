import 'package:flutter_eassypharmacy/core/core.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Center(
          // Add your splash screen UI components here
          child: ClipRRect(
            child: Image.asset(
              Assets.landingPageLogo,
              height: splashHeight,
              width: splashWidth,
            ),
          ),
        ),
      ),
    );
  }
}
