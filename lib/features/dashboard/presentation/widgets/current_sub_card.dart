import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/core/theme/colors.dart';
import 'package:sub_tracker/core/theme/extensions.dart';
import 'package:sub_tracker/core/util/extensions.dart';
import 'package:sub_tracker/core/util/formatter.dart';
import 'package:sub_tracker/features/dashboard/domain/current_subscription.dart';
import 'package:sub_tracker/features/subscription/data/repository/subscription_repository_impl.dart';
import 'package:sub_tracker/features/subscription/domain/models/billing_type.dart';
import 'package:sub_tracker/router/routes.dart';

import '../../../shared/presentation/widgets/primary_button.dart';
import '../../../shared/presentation/widgets/slideup_anim.dart';
import '../../../subscription/presentation/extensions.dart';
import '../cubit/dashboard_cubit.dart';

class CurrentSubCard extends StatelessWidget{
  const CurrentSubCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideUpAnimation(
        child: BlocSelector<DashboardCubit, DashboardState, CurrentSubscription?>(
            selector: (state) {
              if(state case Loaded(:final currentSubscription)){
                return currentSubscription;
              }
              return null;
            },
            builder: (context, sub) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: sub?.plan.getColors()
                        ?? const[AppPalette.secondary, AppPalette.sidebarForeground],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                constraints: BoxConstraints(minHeight: 156),
                padding: const EdgeInsets.all(18),
                child: sub == null ? Column(
                  children: [
                    Text(
                      'No active subscription',
                      style: context.theme.textTheme.bodyMedium
                          .withColor(context.theme.colors.sidebarAccent),
                    ),
                    const SizedBox(height: 18),
                    PrimaryButton(
                      text: 'Subscribe',
                      backgroundColor: context.theme.colors.sidebarBorder,
                      foregroundColor: context.theme.colors.darkSecondary,
                      onPressed: (){
                        context.safePush(Screen.subscribe);
                      },
                    )
                  ],
                ): Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${sub.plan.name} Plan',
                                style: context.theme.textTheme.titleLarge
                                    .withColor(context.theme.colors.sidebarBorder),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${sub.billingType.name} Billing',
                                style: context.theme.textTheme.bodyMedium
                                    .withColor(context.theme.colors.sidebarBorder),
                              )
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: sub.isActive ? context.theme.colors.darkSecondary
                                  : context.theme.colors.darkDestructive,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Text(
                              sub.isActive ? 'Active' : 'Expired',
                              style: context.theme.textTheme.titleSmall
                                  .withColor(context.theme.colors.sidebarBorder),
                            ),
                          )
                        ]
                    ),
                    const SizedBox(height: 26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Days remaining:',
                          style: context.theme.textTheme.bodyMedium
                              .withColor(context.theme.colors.sidebarBorder),
                        ),
                        Text(
                          '${sub.daysLeft}',
                          style: context.theme.textTheme.titleSmall
                              .withColor(context.theme.colors.sidebarBorder),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: LinearProgressIndicator(
                          value: sub.usedDaysProgress,
                          color: context.theme.colors.darkPrimaryForeground,
                          backgroundColor: context.theme.colors.sidebarBorder,
                          borderRadius: BorderRadius.circular(8),
                          minHeight: 8,
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${getSubAmount(sub.plan, sub.billingType).formatPrice()}/'
                              '${sub.billingType == BillingType.monthly ? '':'3'}mo',
                          style: context.theme.textTheme.bodySmall
                              .withColor(context.theme.colors.sidebarBorder),
                        ),
                        Text(
                          'Expires: ${sub.endDate.format()}',
                          style: context.theme.textTheme.bodySmall
                              .withColor(context.theme.colors.sidebarBorder),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
        )
    );
  }
}