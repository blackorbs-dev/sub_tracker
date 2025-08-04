import 'package:flutter/material.dart';
import 'package:sub_tracker/core/theme/extensions.dart';
import 'package:sub_tracker/core/util/formatter.dart';
import '../../data/repository/subscription_repository_impl.dart';
import '../../domain/models/subscription.dart';

class SubInfoCard extends StatelessWidget{
  const SubInfoCard({super.key, required this.sub, required this.color});

  final Subscription sub;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 5,
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sub.location?.address ?? 'Unknown Address',
                      style: context.theme.textTheme.titleMedium
                        .withColor(context.theme.colors.foreground),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${sub.plan.name} Plan',
                      style: context.theme.textTheme.bodyMedium
                        .withColor(context.theme.colors.foreground.withValues(alpha: 0.7)),
                    ),
                  ],
                ),
              )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                getSubAmount(sub.plan, sub.billingType).formatPrice(),
                style: context.theme.textTheme.titleMedium
                    .withColor(context.theme.colors.foreground),
              ),
              const SizedBox(height: 3),
              Text(
                sub.startDate.format(),
                style: context.theme.textTheme.bodyMedium
                    .withColor(context.theme.colors.foreground.withValues(alpha: 0.7)),
              ),
            ],
          )
        ],
      ),
    );
  }

}