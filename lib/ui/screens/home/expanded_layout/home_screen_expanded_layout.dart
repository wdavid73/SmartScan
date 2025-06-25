import 'package:flutter/material.dart';
import 'package:smart_scan/config/config.dart';
import 'package:smart_scan/ui/shared/shared.dart';

class HomeScreenExpandedLayout extends StatelessWidget {
  const HomeScreenExpandedLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: FlutterLogo(
            size: context.dp(25),
          ),
        ),
        AppSpacing.md,
        Text(
          "${context.l10n.home} - Expanded Layout",
          style: context.textTheme.titleLarge,
        ),
      ],
    );
  }
}
