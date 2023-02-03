import 'package:intl/intl.dart';

extension FormatterExtensions on double {
  String get toCurreny {
    final formatCurrency = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: r'R$',
    );
    return formatCurrency.format(this);
  }
}
