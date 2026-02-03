import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';
import '../core/navigation.dart';
import '../pages/home_page.dart';

Future<void> configureWindow() async {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await windowManager.ensureInitialized();
    // await windowManager.setFullScreen(true);
    // await windowManager.setAsFrameless();

    navPARU(const HomePage());
  });
}
