import 'package:flutter/cupertino.dart';
import 'package:sub_tracker/core/theme/extensions.dart';
import 'package:sub_tracker/core/util/formatter.dart';
import '../../../shared/presentation/widgets/slideup_anim.dart';
import '../../../shared/presentation/widgets/svg_icon.dart';

class BalanceBox extends StatelessWidget{
  const BalanceBox({super.key, required this.balance, required this.balanceThisMonth});

  final double balance;
  final double balanceThisMonth;

  @override
  Widget build(BuildContext context) {
    return SlideUpAnimation(child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: context.theme.colors.foreground
      ),
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: context.theme.colors.background.withValues(alpha: 0.4),
                  shape: BoxShape.circle
              ),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              child: SvgIcon(
                'assets/icons/wallet.svg',
                size: 42,
                color: context.theme.colors.background,
              )
          ),
          Text(
            balance.formatPrice(),
            style: context.theme.textTheme.headlineMedium
                .withColor(context.theme.colors.background),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 12),
            child: Text(
              'Available Balance',
              style: context.theme.textTheme.bodyMedium
                  .withColor(context.theme.colors.background),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIcon(
                'assets/icons/trending-up.svg',
                color: context.theme.colors.background,
              ),
              const SizedBox(width: 4,),
              Text(
                '${balanceThisMonth >= 0 ? '+':''}${balanceThisMonth.formatPrice()} this month',
                style: context.theme.textTheme.bodyMedium
                    .withColor(context.theme.colors.background),
              )
            ],
          ),
        ],
      ),
    ));
  }

}