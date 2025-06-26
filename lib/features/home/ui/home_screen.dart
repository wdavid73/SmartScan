import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_scan/config/router/routes_constants.dart';
import 'package:smart_scan/features/home/ui/views/history_view.dart';
import 'package:smart_scan/features/home/ui/views/home_view.dart';
import 'package:smart_scan/features/home/ui/views/settings_view.dart';
import 'package:smart_scan/ui/widgets/widgets.dart';

final Map<String, Widget> _viewRoutes = const <String, Widget>{
  '/home': HomeView(),
  '/history': HistoryView(),
  '/settings': SettingsView(),
};

class HomeScreen extends StatelessWidget {
  final Widget child;
  final String location;

  const HomeScreen({
    super.key,
    required this.child,
    required this.location,
  });

  int _calculateIndex(String location) {
    return _viewRoutes.keys.toList().indexOf(location);
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AppBar(
        title: Text("SmartScan"),
      ),
      bottomNavigationBar: _BottomNavigationBar(
        currentIndex: _calculateIndex(location),
      ),
      child: child,
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const _BottomNavigationBar({
    this.currentIndex = 0,
  });

  void onItemTapped(BuildContext context, int index) {
    String pageName = _viewRoutes.keys.toList()[index].replaceAll('/', '');
    context.go('${RouteConstants.home}/$pageName');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      showSelectedLabels: true,
      onTap: (index) => onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.home_24_filled),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.history_24_filled),
          label: "History",
        ),
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.settings_24_filled),
          label: "Settings",
        ),
      ],
    );
  }
}
