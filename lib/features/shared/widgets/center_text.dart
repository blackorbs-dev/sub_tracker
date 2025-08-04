import 'package:flutter/cupertino.dart';
import 'package:sub_tracker/core/theme/extensions.dart';

class CenterText extends StatelessWidget{
  const CenterText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text, style: context.theme.textTheme.bodySmall
          .withColor(context.theme.colors.foreground.withValues(alpha: 0.7)),
      )
    );
  }

}