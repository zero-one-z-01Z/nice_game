import 'package:flutter/material.dart';
import 'package:nice_game/providers/info_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import '../providers/home_video_provider.dart';

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
      body: InkWell(
        onTap: () {
          context.read<InfoProvider>().goToGenderPage();
        },
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: video.isInitialized
              ? VideoPlayer(video.controller)
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
