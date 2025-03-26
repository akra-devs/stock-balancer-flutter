import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

/// Extension: MoneyMaskedTextController에서 정수값을 쉽게 가져오기 위한 getter
extension MoneyMaskedTextControllerInt on MoneyMaskedTextController {
  int get intValue {
    try {
      return numberValue.toInt();
    } catch (_) {
      return 0;
    }
  }
}

final numberFormatter = NumberFormat('#,###');

extension NumberFormatting on num {
  String toNumberFormat() {
    return numberFormatter.format(this.toInt());
  }

  double toRatioFormat() {
    return (this.toDouble()) / 100;
  }
}

extension LetExtension<T> on T? {
  R? let<R>(R Function(T value) op) {
    if (this != null) {
      return op(this!);
    }
    return null;
  }
}