import 'package:flutter/material.dart';
import 'package:sub_tracker/core/theme/extensions.dart';

import '../../../shared/widgets/svg_icon.dart';
import 'border.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({
    super.key, required this.hint,
    required this.onChanged, this.inputType,
    this.formKey, required this.validator,
    required this.iconAssetName,
  });

  final GlobalKey? formKey;
  final String hint;
  final String iconAssetName;
  final TextInputType? inputType;
  final Function(String value) onChanged;
  final String? Function(String?) validator;

  @override
  State<StatefulWidget> createState() => TextInputFieldState();
}

class TextInputFieldState extends State<TextInputField> {

  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.inputType == TextInputType.visiblePassword;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency, // keeps background invisible
        child: TextFormField(
        key: widget.formKey,
        style: context.theme.textTheme.bodySmall
            .withColor(context.theme.colors.foreground),
        keyboardType: widget.inputType,
        validator: widget.validator,
        obscureText: _obscureText,
        decoration: InputDecoration(
          isDense: true, hintText: widget.hint,
          prefixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 6, 12),
              child: SvgIcon(widget.iconAssetName, color: context.theme.colors.sidebarForeground,)
          ),
          hintStyle: context.theme.textTheme.bodySmall
            .withColor(context.theme.colors.sidebarForeground),
          border: outlinedBorder(color: context.theme.colors.sidebarForeground),
          enabledBorder: outlinedBorder(color: context.theme.colors.sidebarForeground),
          focusedBorder: outlinedBorder(color: context.theme.colors.sidebarForeground),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          suffixIcon: widget.inputType == TextInputType.visiblePassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: SvgIcon(
                    _obscureText ? 'assets/icons/eye-off.svg' : 'assets/icons/eye.svg',
                    color: context.theme.colors.sidebarForeground,
                  )
              ) : null,
        ),
        onChanged: widget.onChanged
    ));
  }

}