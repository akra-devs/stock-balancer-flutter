import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

/// Extension: MoneyMaskedTextController에서 정수값을 쉽게 가져오기 위한 getter
extension MoneyMaskedTextControllerInt on MoneyMaskedTextController {
  int get intValue => numberValue.toInt();
}

final numberFormatter = NumberFormat('#,###');

extension NumberFormatting on num {
  String toNumberFormat() {
    return numberFormatter.format(this.toInt());
  }
}
