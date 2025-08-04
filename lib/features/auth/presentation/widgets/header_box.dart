import 'package:flutter/material.dart';
import 'package:sub_tracker/core/theme/extensions.dart';

class HeaderBox extends StatelessWidget{
  const HeaderBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      padding: const EdgeInsets.all(24),
      constraints: const BoxConstraints(maxWidth: 600),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.theme.colors.darkSecondary,
            context.theme.colors.sidebarRing
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        ),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        children: [
          Text(
            'SubTracker', style: context.theme.textTheme.headlineMedium
              .withColor(context.theme.colors.sidebarBorder),
          ),
          const SizedBox(height: 12),
          Text(
            'Manage your subscriptions smartly',
            style: context.theme.textTheme.bodyMedium
              .withColor(context.theme.colors.sidebarBorder),
          )
        ],
      ),
    );
  }

}