import 'package:flutter_eassypharmacy/core/core.dart';

import 'loading_page.dart';

class LoadingButton extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? circular;

  const LoadingButton({
    this.color,
    this.height,
    this.circular = space8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height ?? space48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(circular!),
      ),
      child: LoadingPage(size: space20, color: color),
    );
  }
}
