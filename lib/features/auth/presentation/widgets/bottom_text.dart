import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:sub_tracker/core/theme/extensions.dart';

class BottomText extends StatelessWidget{
  const BottomText({
    super.key,
    required this.text,
    required this.actionText,
    required this.onAction
  });

  final String text;
  final String actionText;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Align(child: Padding(
        padding: const EdgeInsets.only(bottom: 46),
        child: RichText(
            text: TextSpan(
                children: [
                  TextSpan(
                      text: text,
                      style: context.theme.textTheme.bodySmall
                          .withColor(context.theme.colors.foreground)
                  ),
                  TextSpan(
                      text: actionText,
                      style: context.theme.textTheme.titleSmall
                          ?.copyWith(
                            decoration: TextDecoration.underline,
                            color: context.theme.colors.foreground,
                            fontWeight: FontWeight.w700
                        ),
                      recognizer: TapGestureRecognizer()..onTap = onAction
                  )
                ]
            )
        ),
    ));
  }

}