import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_scan/app/dependency_injection.dart';
import 'package:smart_scan/features/auth/auth.dart';

class WrapperBlocProvidersAuth extends StatelessWidget {
  final Widget child;
  const WrapperBlocProvidersAuth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt.get<AuthBloc>();
    final signInCubit = getIt.get<SignInFormCubit>();
    final registerCubit = getIt.get<RegisterFormCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider(create: (context) => signInCubit),
        BlocProvider(create: (context) => registerCubit),
      ],
      child: child,
    );
  }
}
