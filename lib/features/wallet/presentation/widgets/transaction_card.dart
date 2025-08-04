import 'package:flutter/cupertino.dart';
import 'package:sub_tracker/core/theme/extensions.dart';
import 'package:sub_tracker/core/util/formatter.dart';
import 'package:sub_tracker/features/wallet/presentation/extensions.dart';

import '../../../shared/widgets/svg_icon.dart';
import '../../domain/models/transaction.dart';

class TransactionCard extends StatelessWidget{
  const TransactionCard({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: transaction.iconColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8)
            ),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(right: 12),
            child: SvgIcon(transaction.iconAssets, color: transaction.iconColor,),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: context.theme.textTheme.titleMedium
                    .withColor(context.theme.colors.foreground),
                ),
                const SizedBox(height: 3,),
                Text(
                  transaction.date.format(),
                  style: context.theme.textTheme.bodyMedium
                      .withColor(context.theme.colors.foreground.withValues(alpha: 0.7)),
                )
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '${transaction.sign}${transaction.amount.formatPrice()}',
                style: context.theme.textTheme.titleMedium
                    .withColor(transaction.textColor??context.theme.colors.foreground),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: transaction.backColor
                ),
                margin: const EdgeInsets.only(top: 3),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Text(
                  transaction.status.name,
                  style: context.theme.textTheme.labelSmall
                      .withColor(context.theme.colors.sidebarBorder),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}