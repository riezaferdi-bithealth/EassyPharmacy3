import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class CartIsEmpty extends StatelessWidget {
  const CartIsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          Assets.cartIsEmptyImage,
          scale: searchNotFoundImageSize,
        ),
        const ColumnDivider(padding: space16),
        Text(
          cartIsEmpty,
          style: p16.primary.bold,
        ),
      ],
    );
  }
}
