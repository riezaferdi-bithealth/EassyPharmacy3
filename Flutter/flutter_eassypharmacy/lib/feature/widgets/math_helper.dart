import 'dart:math';

import '../../core/core.dart';

class MathHelper {
  String getRandomString(int length) {
    const chars = randomChars;
    Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }
}
