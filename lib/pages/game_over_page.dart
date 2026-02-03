import 'package:flutter/material.dart';
import 'package:nice_game/providers/game_over_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class GameOverPage extends StatefulWidget {
  const GameOverPage({super.key, required this.path});
  final String path;

  @override
  State<GameOverPage> createState() => _GameOverPageState();
}

class _GameOverPageState extends State<GameOverPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameOverVideoProvider>().init(widget.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameOverVideoProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: provider.isInitialized
            ? VideoPlayer(provider.controller)
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
