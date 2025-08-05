import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/core/theme/extensions.dart';
import 'package:sub_tracker/core/util/formatter.dart';
import 'package:sub_tracker/features/subscription/domain/models/billing_type.dart';
import 'package:sub_tracker/features/subscription/presentation/bloc/subscription_bloc.dart';
import '../../../shared/presentation/widgets/primary_button.dart';
import '../../../shared/presentation/widgets/slideup_anim.dart';
import '../../../shared/presentation/widgets/svg_icon.dart';
import '../../data/repository/subscription_repository_impl.dart';
import '../extensions.dart';
import '../../domain/models/subscription_plan.dart';

class SubPlanCard extends StatelessWidget{
  const SubPlanCard({
    super.key, required this.subPlan,
    required this.isCurrent, required this.isSelected,
    required this.billingType, required this.isLoading
  });

  final SubscriptionPlan subPlan;
  final BillingType billingType;
  final bool isCurrent;
  final bool isSelected;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SlideUpAnimation(child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: subPlan.getColors(),
            ),
            borderRadius: BorderRadius.circular(16)
        ),
        constraints: BoxConstraints(minHeight: 320),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: context.theme.colors.sidebarBorder.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 4, right: 10),
                  child: SvgIcon(
                    subPlan.iconAsset, size: 28,
                    color: context.theme.colors.sidebarBorder,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subPlan.name,
                      style: context.theme.textTheme.titleLarge
                          .withColor(context.theme.colors.sidebarBorder),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${getSubAmount(subPlan, billingType).formatPrice()}/'
                          '${billingType == BillingType.monthly ? '':'3'}month',
                      style: context.theme.textTheme.bodyMedium
                          .withColor(context.theme.colors.sidebarBorder),
                    )
                  ],
                ),
                if(isCurrent) ...[
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: context.theme.colors.darkSecondary,
                        borderRadius: BorderRadius.circular(18)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Text(
                      'Current',
                      style: context.theme.textTheme.titleSmall
                          .withColor(context.theme.colors.sidebarBorder),
                    ),
                  )
                ]
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: subPlan.perks.map((item){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                        children: [
                          SvgIcon(
                            'assets/icons/check.svg',
                            color: context.theme.colors.sidebarBorder,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item, style: context.theme.textTheme.bodyMedium
                              .withColor(context.theme.colors.sidebarBorder),
                          )
                        ]
                    ),
                  );
                }).toList(),
              ),
            ),
            PrimaryButton(
              text: isCurrent ? 'Renew Plan' : 'Subscribe',
              onPressed: (){
                context.read<SubscriptionBloc>().add(Subscribe(subPlan));
              },
              enabled: !isLoading,
              isLoading: isLoading && isSelected,
              backgroundColor: context.theme.colors.sidebarBorder,
              foregroundColor: context.theme.colors.darkPrimaryForeground,
            ),
            if(isCurrent)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: TextButton(
                    style: TextButton.styleFrom(
                        textStyle: context.theme.textTheme.titleSmall,
                        foregroundColor: context.theme.colors.sidebarBorder
                    ),
                    onPressed: (){
                      context.read<SubscriptionBloc>().add(CancelSubscription());
                    },
                    child: const Text('Cancel Subscription')
                ),
              )
          ],
        )
    ));
  }

}