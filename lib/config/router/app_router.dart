import 'package:smart_scan/config/config.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_scan/features/auth/bloc/auth_bloc.dart';
import 'go_router_notifier.dart';
import 'redirect_handler.dart';
import 'routes_generator.dart';

/* String? _handleOnboardingRedirect(BuildContext context, GoRouterState state) {
  if (Environment.showOnboarding == true) {
    final introductionCubit = getIt.get<IntroductionCubit>();

    if (introductionCubit.state.isLoading) {
      return null;
    }

    final isOnboardingCompleted = introductionCubit.state.hasSeen;
    final currentPath = state.uri.path;

    if (!isOnboardingCompleted &&
        currentPath != RouteConstants.onboardingScreen) {
      return RouteConstants.onboardingScreen;
    }
  }
  return null;
} */

/// Creates and configures the application's [GoRouter] instance.
///
/// This function initializes the [GoRouter] with the application's routes,
/// initial location, refresh listener, and redirection logic. It uses a
/// [GoRouterNotifier] to listen for changes in the authentication state and
/// the [appRedirect] function to handle redirection based on the current
/// authentication status and route.
///
/// Parameters:
///   - [authBloc]: The [AuthBloc] instance used to manage the authentication state.
///
/// Returns:
///   - A configured [GoRouter] instance ready to be used in the application.
GoRouter createAppRouter(AuthBloc authBloc) {
  final goRouterNotifier = GoRouterNotifier(authBloc);

  return GoRouter(
    initialLocation: "${RouteConstants.home}/home",
    refreshListenable: goRouterNotifier,
    routes: AppRoutes.getAppRoutes(),
    redirect: (context, state) {
      /* final onboardingRedirect = _handleOnboardingRedirect(context, state);

      if (onboardingRedirect != null) {
        return onboardingRedirect;
      }

      final isOnboardingCompleted =
          getIt.get<IntroductionCubit>().state.hasSeen;

      return appRedirect(
        goRouterNotifier,
        state,
        Environment.showOnboarding == true ? isOnboardingCompleted : true,
      ); */
      return null;
    },
  );
}
