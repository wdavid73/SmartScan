import 'package:flutter/material.dart';
import 'package:smart_scan/app/app.dart';
import 'package:smart_scan/config/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Optional:  Locks the app orientation to portrait mode.
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

  /// Initializes the app before running the main application.
  await AppInitializer.init(flavor: "prod");

  /// Runs the main application widget.
  runApp(const MainApp());
}
