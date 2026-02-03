import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../core/constants.dart';
import 'app_providers.dart';
import 'window_config.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    configureWindow();
  }

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: LayoutBuilder(
        builder: (_, __) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: Constants.navState,
                navigatorObservers: [routeObserver],
                home: const _BootScreen(),
              );
            },
          );
        },
      ),
    );
  }
}

class _BootScreen extends StatelessWidget {
  const _BootScreen();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: 100.w,
      height: 100.h,
    );
  }
}
