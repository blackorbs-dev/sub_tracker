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
  });

  final bool isLoading;
  final bool enabled;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: FilledButton(
          style: FilledButton.styleFrom(
            fixedSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            foregroundColor: context.theme.colors.background,
            backgroundColor: context.theme.colors.primary,
            disabledForegroundColor: context.theme.colors.background,
            disabledBackgroundColor: context.theme.colors.primaryGlow,
            textStyle: context.theme.textTheme.bodySmall,
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
