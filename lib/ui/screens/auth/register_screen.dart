import 'package:flutter/material.dart';
import 'package:smart_scan/config/config.dart';
import 'package:smart_scan/ui/views/views.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () => context.unfocus(),
        child: RegisterView(),
      ),
    );
  }
}
