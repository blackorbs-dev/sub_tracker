import 'dart:ui';
import '../domain/models/transaction.dart';
import '../domain/models/transaction_status.dart';
import '../domain/models/transaction_type.dart';

extension UIProperty on Transaction{

  String get sign => switch(type){
    TransactionType.credit => '+',
    TransactionType.debit => '-',
  };

  String get iconAssets => switch(type){
    TransactionType.credit => 'assets/icons/arrow-up-right.svg',
    TransactionType.debit => 'assets/icons/arrow-down-left.svg',
  };

  Color get iconColor => switch(type){
    TransactionType.credit => const Color(0xFF16a34a),
    TransactionType.debit => const Color(0xFFf59e0b),
  };

  Color? get textColor{
    if(status == TransactionStatus.failed) {
      return const Color(0xFF7f1d1d);
    }
    if(type == TransactionType.credit){
      return const Color(0xFF16a34a);
    }
    return null;
  }

  Color get backColor{
    if(status == TransactionStatus.failed){
      return const Color(0xFF7f1d1d);
    }
    return const Color(0xFF404040);
  }

}