import 'dart:io';
import 'package:flutter/material.dart';
import 'app/my_app.dart';
import 'core/http_overrides.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}
