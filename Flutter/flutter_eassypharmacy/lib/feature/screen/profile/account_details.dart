import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  String? fullNameUser;
  String? emailUser;
  String? phoneUser;

  @override
  void initState() {
    _stateToken();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _stateToken() async {
    fullNameUser = await AccountHelper.getUserFullName();
    emailUser = await AccountHelper.getUserEmail();
    phoneUser = await AccountHelper.getUserPhoneNumber();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          profileDetail,
          style: p24.primary.semiBold,
        ),
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
        width: MediaQuery.of(context).size.width,
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
        child: Padding(
          padding: const EdgeInsets.all(space16),
          child: topBarSection(),
        ),
      ),
    );
  }

  Widget topBarSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Full Name: $fullNameUser",
          style: p20.primary.medium,
        ),
        Text(
          "Email: $emailUser",
          style: p20.primary.medium,
        ),
        Text(
          "Phone Number: $phoneUser",
          style: p20.primary.medium,
        ),
      ],
    );
  }
}
