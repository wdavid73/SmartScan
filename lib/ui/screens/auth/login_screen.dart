import 'package:flutter/material.dart';
import 'package:smart_scan/config/config.dart';
import 'package:smart_scan/ui/views/views.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () => context.unfocus(),
        child: LoginView(),
      ),
    );
  }
}
