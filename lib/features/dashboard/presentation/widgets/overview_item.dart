import 'package:flutter/cupertino.dart';
import 'package:sub_tracker/core/theme/extensions.dart';

class OverviewItem extends StatelessWidget{
  const OverviewItem({super.key, required this.title, required this.text, this.textColor});

  final String title;
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title, style: context.theme.textTheme.bodyMedium
              .withColor(context.theme.colors.foreground),
          ),
          Text(
            text, style: context.theme.textTheme.titleMedium
              .withColor(textColor??context.theme.colors.foreground),
          ),
        ],
      ),
    );
  }

}