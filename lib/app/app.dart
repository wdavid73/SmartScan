import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_scan/app/dependency_injection.dart';
import 'package:smart_scan/config/config.dart';
import 'package:smart_scan/features/auth/bloc/auth_bloc.dart';
import 'package:smart_scan/ui/cubits/cubits.dart';
import 'package:go_router/go_router.dart';

/// The [GoRouter] instance used for navigation.
GoRouter? _router;

final _themeMode = getIt.get<ThemeModeCubit>();
final _authBloc = getIt<AuthBloc>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    _router ??= createAppRouter(_authBloc);

    return BlocSelector<ThemeModeCubit, ThemeModeState, bool>(
      bloc: _themeMode,
      selector: (state) => state.isDarkMode,
      builder: (context, isDark) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          title: Environment.appName,
          theme: AppTheme.getLightTheme(context),
          darkTheme: AppTheme.getDarkTheme(context),
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
