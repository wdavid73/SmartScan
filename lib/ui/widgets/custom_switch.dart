import 'package:flutter/material.dart';
import 'package:smart_scan/config/config.dart';
import 'package:smart_scan/ui/shared/shared.dart';

class CustomSwitch extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Icon? icon;
  final bool switchValue;
  final void Function(bool)? onChanged;
  const CustomSwitch({
    super.key,
    required this.title,
    this.icon,
    this.switchValue = false,
    this.onChanged,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) icon!,
            AppSpacing.sm,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium,
                ),
                if (subTitle != null)
                  Text(
                    "$subTitle",
                    style: context.textTheme.bodySmall?.copyWith(
                      color: ColorTheme.textSecondary,
                    ),
                  ),
              ],
            )
          ],
        ),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: switchValue,
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}
