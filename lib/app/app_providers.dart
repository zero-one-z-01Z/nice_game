import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/info_provider.dart';
import '../providers/question_provider.dart';
import '../providers/home_video_provider.dart';
import '../providers/question_video_provider.dart';
import '../providers/game_over_provider.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InfoProvider()),
        ChangeNotifierProvider(create: (_) => QuestionProvider()),
        ChangeNotifierProvider(create: (_) => HomeVideoProvider()),
        ChangeNotifierProvider(create: (_) => QuestionVideoProvider()),
        ChangeNotifierProvider(create: (_) => GameOverVideoProvider()),
      ],
      child: child,
    );
  }
}
