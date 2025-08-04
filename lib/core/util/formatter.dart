import 'package:intl/intl.dart';

extension PriceFormatting on double {
  String formatPrice() => NumberFormat.currency(symbol: '\$').format(this);
}

extension DateFormatting on DateTime {
  String format({String pattern = 'dd/MM/yyyy'}) => DateFormat(pattern).format(this);
}
