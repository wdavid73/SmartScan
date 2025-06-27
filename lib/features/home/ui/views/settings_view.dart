import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_scan/app/dependency_injection.dart';
import 'package:smart_scan/config/config.dart';
import 'package:smart_scan/features/home/cubits/settings_cubit/settings_cubit.dart';
import 'package:smart_scan/ui/cubits/cubits.dart';
import 'package:smart_scan/ui/shared/styles/app_spacing.dart';
import 'package:smart_scan/ui/widgets/widgets.dart';
import 'package:smart_scan/utils/ocr_languages.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  void _showLanguageDialog(BuildContext context, String currentLang) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text("Select OCR language"),
        children: supportedOcrLanguages.entries.map((entry) {
          return RadioListTile(
            value: entry.key,
            groupValue: currentLang,
            title: Text(entry.value),
            onChanged: (value) {
              getIt.get<SettingsCubit>().setOcrLanguage(value!);
              Navigator.pop(ctx);
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text(
            context.l10n.general,
            style: context.textTheme.titleMedium,
          ),
          AppSpacing.md,
          BlocSelector<SettingsCubit, SettingsState, bool>(
            bloc: getIt.get<SettingsCubit>(),
            selector: (state) => state.ocrEnabled,
            builder: (context, ocrEnabled) {
              return CustomSwitch(
                title: "Auto OCR",
                subTitle: "Detect text automatically",
                switchValue: ocrEnabled,
                onChanged: (val) {
                  getIt.get<SettingsCubit>().toggleOcr(val);
                },
              );
            },
          ),
          BlocSelector<SettingsCubit, SettingsState, String>(
            bloc: getIt.get<SettingsCubit>(),
            selector: (state) => state.ocrLanguage,
            builder: (context, ocrLanguage) {
              return _ItemSettings(
                title: "OCR Language",
                subTitle: "Current: $ocrLanguage",
                icon: FluentIcons.local_language_24_filled,
                onTap: () {
                  _showLanguageDialog(context, ocrLanguage);
                },
              );
            },
          ),
          AppSpacing.lg,
          Text(
            context.l10n.theme,
            style: context.textTheme.titleSmall,
          ),
          AppSpacing.sm,
          BlocSelector<ThemeModeCubit, ThemeModeState, bool>(
            bloc: getIt.get<ThemeModeCubit>(),
            selector: (state) => state.isDarkMode,
            builder: (context, isDarkMode) {
              return CustomSwitch(
                icon: Icon(Icons.dark_mode_outlined, size: context.dp(2.6)),
                title: context.l10n.darkTheme,
                switchValue: isDarkMode,
                onChanged: (_) {
                  getIt.get<ThemeModeCubit>().toggleTheme();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ItemSettings extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subTitle;
  final void Function()? onTap;
  const _ItemSettings({
    required this.icon,
    required this.title,
    this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: context.textTheme.bodyMedium,
          ),
          subtitle: subTitle != null
              ? Text(
                  "$subTitle",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: ColorTheme.textSecondary,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.zero,
          onTap: onTap,
        ),
        Divider(height: 0, endIndent: 0, indent: 0),
      ],
    );
  }
}
