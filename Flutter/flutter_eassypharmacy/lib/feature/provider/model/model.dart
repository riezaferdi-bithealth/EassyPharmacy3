// ignore_for_file: unnecessary_null_comparison
export 'package:flutter_eassypharmacy/feature/provider/model/model.dart';

export 'home/get_list_medicines.dart';
export 'base_model.dart';

abstract class Model {
  static String? castString(var object, [String? defaultValue]) {
    defaultValue = "";

    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : object as String;
  }

  static int? castInt(var object, [int? defaultValue]) {
    defaultValue = 0;

    if (object == null && defaultValue == null) return null;

    if (object == null) {
      return defaultValue;
    } else {
      if (object is num) {
        return (object).toInt();
      } else if (object is String) {
        return int.tryParse(object);
      } else {
        return null;
      }
    }
  }

  static double? castDouble(var object, [double? defaultValue]) {
    defaultValue = 0;

    if (object == null && defaultValue == null) return null;

    if (object == null) {
      return defaultValue;
    } else {
      if (object is num) {
        return (object).toDouble();
      } else if (object is String) {
        return double.tryParse(object);
      } else {
        return null;
      }
    }
  }

  static bool? castBool(var object, [bool? defaultValue]) {
    defaultValue = false;

    if (object == null && defaultValue == null) return null;

    if (object == null) {
      return defaultValue;
    } else {
      if (object is bool) {
        return object;
      } else if (object is String) {
        return object == "1" ? true : false;
      } else if (object is num) {
        return object == 1 ? true : false;
      } else {
        return null;
      }
    }
  }

  static List? castList(var object, [List? defaultValue]) {
    defaultValue = [];

    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : object as List;
  }
}
