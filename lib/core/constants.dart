import 'package:flutter/material.dart';

class Constants{
  static const String baseUri = 'https://api.mazoboothmirror.com/';
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();


  static BuildContext globalContext(){
    return navState.currentContext!;
  }
}

