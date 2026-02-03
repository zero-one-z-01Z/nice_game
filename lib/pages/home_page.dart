import 'package:flutter/material.dart';
import 'package:nice_game/providers/home_video_provider.dart';
import 'package:nice_game/providers/info_provider.dart';
import 'package:provider/provider.dart';
import 'package:media_kit_video/media_kit_video.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeVideoProvider>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final video = context.watch<HomeVideoProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox.expand(
            child: video.isInitialized
                ? Video(
                    controller: video.controller,
                    fit: BoxFit.cover,
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          // Transparent layer to capture clicks
          Positioned.fill(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  context.read<InfoProvider>().goToGenderPage();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
