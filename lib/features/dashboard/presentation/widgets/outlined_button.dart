import 'package:flutter/material.dart';
import 'package:sub_tracker/core/theme/extensions.dart';
import '../../../shared/presentation/widgets/svg_icon.dart';

class OutlinedButtonLarge extends StatelessWidget{
  const OutlinedButtonLarge({super.key, required this.text, required this.iconAsset, required this.onPressed});

  final String text;
  final String iconAsset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: context.theme.colors.foreground,
        textStyle: context.theme.textTheme.titleSmall,
        backgroundColor: context.theme.colors.darkRing,
        maximumSize: const Size.fromHeight(84),
        side: BorderSide(width: 2, color: context.theme.colors.darkMutedForeground),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(iconAsset, color: context.theme.colors.foreground,),
          const SizedBox(height: 10),
          Text(text),
        ],
      ),
    );
  }
}

class OutlinedButtonSmall extends StatelessWidget{
  const OutlinedButtonSmall({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: context.theme.colors.foreground,
        textStyle: context.theme.textTheme.titleSmall,
        backgroundColor: context.theme.colors.darkRing,
        side: BorderSide(width: 2, color: context.theme.colors.darkMutedForeground),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
      ),
      child: Text(text),
    );
  }
}