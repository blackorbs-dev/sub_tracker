import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub_tracker/core/theme/extensions.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.isLoading = false,
    this.enabled = true,
    required this.text,
    required this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
  });

  final bool isLoading;
  final bool enabled;
  final String text;
  final VoidCallback onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: FilledButton(
          style: FilledButton.styleFrom(
            fixedSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            foregroundColor: foregroundColor ?? context.theme.colors.background,
            backgroundColor: backgroundColor ?? context.theme.colors.foreground,
            disabledForegroundColor: context.theme.colors.background.withValues(alpha: 0.6),
            disabledBackgroundColor: context.theme.colors.foreground.withValues(alpha: 0.6),
            textStyle: context.theme.textTheme.titleSmall,
          ),
          onPressed: (enabled && !isLoading) ? onPressed : null,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 320),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: isLoading
                ? CupertinoActivityIndicator(
                key: ValueKey('loading'),
                radius: 12,
                color: context.theme.colors.background,
            ) : Text(text, key: const ValueKey('text'),),
          ),
        )
    );
  }
}
