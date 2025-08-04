import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/core/theme/extensions.dart';
import 'package:sub_tracker/features/subscription/domain/repository/subscription_repository.dart';
import '../../domain/models/billing_type.dart';
import '../bloc/subscription_bloc.dart';

class BillingToggle extends StatelessWidget {
  const BillingToggle({super.key, required this.billingType});

  final BillingType billingType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical:  12),
      decoration: BoxDecoration(
        color: context.theme.colors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: BillingType.values.map((type) {
          final isSelected = billingType == type;
          return Expanded(child: GestureDetector(
            onTap: () {
              context.read<SubscriptionBloc>().add(BillingTypeChanged(type));
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? context.theme.colors.sidebarBorder : context.theme.colors.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    type.name, style: context.theme.textTheme.titleSmall.withColor(
                      isSelected ? context.theme.colors.darkSecondary
                          : context.theme.colors.darkMutedForeground),
                  ),
                  if(type == BillingType.quarterly)
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Save ${SubscriptionRepository.discount}%',
                        style: context.theme.textTheme.titleSmall
                          .withColor(
                            isSelected ? context.theme.colors.darkMutedForeground
                                : context.theme.colors.sidebarAccent
                        ),
                      ),
                    )
                ],
              ),
            ),
          ));
        }).toList(),
      ),
    );
  }
}