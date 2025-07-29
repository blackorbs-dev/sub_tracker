import 'package:intl/intl.dart';

extension IntFormatting on int {
  /// format a number in thousands, millions, billions, etc.
  String format() => NumberFormat.decimalPattern().format(this);
}

extension TimeFormatting on DateTime {
  String toTimeString() => DateFormat.yMMMEd().format(this);
}
