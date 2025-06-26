import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum TransitionType { slideRight, slideLeft, fade, slideAndFade }

class TransitionManager {
  static CustomTransitionPage<void> buildCustomTransitionPage({
    required Widget child,
    TransitionType? transitionType,
    GoRouterState? state,
  }) {
    Duration transitionDuration = Duration(milliseconds: 300);

    return CustomTransitionPage(
      key: state?.pageKey,
      child: child,
      transitionDuration: transitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transitionType) {
          case TransitionType.slideRight:
            return _slideTransition(animation, child, Offset(1.0, 0.0));
          case TransitionType.slideLeft:
            return _slideTransition(animation, child, Offset(-1.0, 0.0));
          case TransitionType.fade:
            return _fadeTransition(animation, child);
          case TransitionType.slideAndFade:
            return _slideAndFadeTransition(animation, child, Offset(1.0, 0.0));
          default:
            return child;
        }
      },
    );
  }

  static SlideTransition _slideTransition(
    Animation<double> animation,
    Widget child,
    Offset begin,
  ) {
    const curve = Curves.easeInOut;
    var tween = Tween(
      begin: begin,
      end: Offset.zero,
    ).chain(
      CurveTween(curve: curve),
    );
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }

  static FadeTransition _fadeTransition(
    Animation<double> animation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
      child: child,
    );
  }

  static Widget _slideAndFadeTransition(
    Animation<double> animation,
    Widget child,
    Offset begin,
  ) {
    const curve = Curves.easeInOut;

    var slideTween = Tween(
      begin: begin,
      end: Offset.zero,
    ).chain(
      CurveTween(curve: curve),
    );
    var slideAnimation = animation.drive(slideTween);

    var fadeTween =
        Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
    var fadeAnimation = animation.drive(fadeTween);

    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: child,
      ),
    );
  }
}
