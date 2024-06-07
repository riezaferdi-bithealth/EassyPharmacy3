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

  _stateToken() async {
    fullNameUser = await AccountHelper.getUserFullName();
    emailUser = await AccountHelper.getUserEmail();
    phoneUser = await AccountHelper.getUserPhoneNumber();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _stateToken();
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
      body: Padding(
        padding: const EdgeInsets.all(space16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            topBarSection(),
          ],
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
