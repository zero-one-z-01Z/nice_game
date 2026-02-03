import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'app/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  // HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}
