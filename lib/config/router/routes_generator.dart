import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_scan/features/auth/ui/ui.dart';
import 'package:smart_scan/features/home/ui/ui.dart';
import 'package:smart_scan/features/preview/ui/pdf_viewer_screen.dart';
import 'package:smart_scan/features/preview/ui/preview_screen.dart';
import 'package:smart_scan/features/scan/ui/scan_screen.dart';
import 'package:smart_scan/ui/screens/screens.dart';
import 'routes_constants.dart';
import 'routes_transitions.dart';

/// A utility class that defines the application's route paths and generates the
/// [GoRouter] route configuration.
///
/// This class provides constants for each route path and a method to generate
/// the list of [RouteBase] objects used by [GoRouter].
class AppRoutes {
  /// Generates the list of [RouteBase] objects for the application.
  ///
  /// This method defines the route hierarchy and associates each route path
  /// with its corresponding screen or view. It also defines nested routes
  /// for the widgets screen.
  ///
  /// Returns:
  ///   - A [List] of [RouteBase] objects representing the application's routes.
  static List<RouteBase> getAppRoutes() {
    return [
      ///* SPLASH SCREEN
      GoRoute(
        path: RouteConstants.splash,
        name: "splash",
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* HOME ROUTE
      ShellRoute(
        builder: (context, state, child) {
          return HomeScreen(location: state.matchedLocation, child: child);
        },
        routes: [
          GoRoute(
            path: "${RouteConstants.home}/home",
            name: "home",
            builder: (context, state) => const HomeView(),
          ),
          GoRoute(
            path: "${RouteConstants.home}/history",
            name: "history",
            builder: (context, state) => const HistoryView(),
          ),
          GoRoute(
            path: "${RouteConstants.home}/settings",
            name: "settings",
            builder: (context, state) => const SettingsView(),
          ),
        ],
      ),

      GoRoute(
        path: RouteConstants.scanScreen,
        name: "scan_screen",
        pageBuilder: (context, state) => _transitionPage(
          transitionType: TransitionType.slideRight,
          child: const ScanScreen(),
        ),
      ),

      GoRoute(
        path: RouteConstants.previewScreen,
        name: "preview_screen",
        pageBuilder: (context, state) {
          final String imagePath = state.extra as String;
          return _transitionPage(
            transitionType: TransitionType.slideRight,
            child: PreviewScreen(imagePath: imagePath),
          );
        },
      ),

      GoRoute(
        path: RouteConstants.pdfViewerScreen,
        name: "pdf_viewer_screen",
        pageBuilder: (context, state) {
          final String filePath = state.extra as String;
          return _transitionPage(
            transitionType: TransitionType.slideRight,
            child: PdfViewerScreen(filePath: filePath),
          );
        },
      ),
      /*  */

      /// SETTINGS ROUTE
      /* GoRoute(
        path: RouteConstants.settingsScreen,
        name: "settings",
        /*builder: (context, state) => const SettingsScreen(),*/
        pageBuilder: (_, __) => _transitionPage(
          child: const SettingsScreen(),
          transitionType: TransitionType.slideRight,
        ),
      ), */

      /// ONBOARDING ROUTE
      /* GoRoute(
        path: RouteConstants.onboardingScreen,
        name: "onboarding",
        pageBuilder: (_, __) => _transitionPage(
          child: const OnBoardingScreen(),
          transitionType: TransitionType.fade,
        ),
      ), */

      ///* AUTH ROUTES
      GoRoute(
        path: RouteConstants.loginScreen,
        name: "login",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteConstants.registerScreen,
        name: "register",
        builder: (context, state) => const RegisterScreen(),
      ),
    ];
  }
}

CustomTransitionPage<void> _transitionPage({
  required Widget child,
  TransitionType? transitionType,
  GoRouterState? state,
}) =>
    TransitionManager.buildCustomTransitionPage(
      child: child,
      transitionType: transitionType,
      state: state,
    );
