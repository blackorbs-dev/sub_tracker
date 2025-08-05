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
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderTitle(
              text: 'SubTracker',
              bottomPadding: 12,
              color: context.theme.colors.sidebarBorder,
          ),
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

class HeaderTitle extends StatelessWidget{
  const HeaderTitle({super.key, required this.text, this.bottomPadding = 28, this.color});

  final String text;
  final Color? color;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Text(
        text, textAlign: TextAlign.center,
        style: context.theme.textTheme.headlineMedium
          .withColor(color ?? context.theme.colors.foreground),
      ),
    );
  }
}