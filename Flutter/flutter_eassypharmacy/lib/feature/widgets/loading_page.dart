import 'package:flutter_eassypharmacy/core/core.dart';

class LoadingPage extends StatelessWidget {
  final double size;
  final Color? color;

  const LoadingPage({this.size = space30, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        strokeWidth: space4,
        backgroundColor: systemWhiteColor,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? systemAccentColor),
      ),
    );
  }
}
