import 'package:flutter_eassypharmacy/core/core.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';

class SearchNotFound extends StatelessWidget {
  const SearchNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          Assets.searchNotFoundImage,
          scale: searchNotFoundImageSize,
        ),
        const ColumnDivider(padding: space16),
        Text(
          searchNotFound,
          style: p16.primary.bold,
        ),
      ],
    );
  }
}
