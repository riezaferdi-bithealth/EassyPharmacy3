import 'package:flutter/material.dart';

class RowDivider extends StatelessWidget {
  final double padding;
  const RowDivider({
    super.key,
    required this.padding,
  });

  // int index = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: padding,
    );
  }
}

class ColumnDivider extends StatelessWidget {
  final double padding;
  const ColumnDivider({
    super.key,
    required this.padding,
  });

  // int index = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: padding,
    );
  }
}
