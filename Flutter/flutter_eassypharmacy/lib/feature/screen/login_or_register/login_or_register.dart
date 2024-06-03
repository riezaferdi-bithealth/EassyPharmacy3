import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'login/login.dart';
import 'register/register.dart';

class LoginOrRegisterPage extends StatelessWidget {
  const LoginOrRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: systemPrimaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        // color: systemWhiteColor,
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
              Colors.blue.shade200,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(space16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const ColumnDivider(padding: topBarPadding),
              Image.asset(
                Assets.landingPageLogo,
                height: splashHeight,
                width: splashWidth,
              ),
              // Text(loginOrRegister, style: p30.primary.bold),
              const ColumnDivider(padding: space30),
              GeneralButton.text(
                login,
                padding: const EdgeInsets.symmetric(vertical: space12),
                buttonSize: ButtonSize.large,
                backgroundColor: systemPrimaryColor,
                width: double.infinity,
                height: 56,
                circular: space12,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                },
              ),
              const ColumnDivider(padding: space16),
              GeneralButton.text(
                register,
                padding: const EdgeInsets.symmetric(vertical: space12),
                buttonSize: ButtonSize.large,
                backgroundColor: systemPrimaryColor,
                width: double.infinity,
                height: 56,
                circular: space12,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RegisterPage();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
