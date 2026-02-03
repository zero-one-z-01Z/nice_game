import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class HomeVideoProvider extends ChangeNotifier {
  late Player player;
  late VideoController controller;
  bool _initialized = false;

  bool get isInitialized => _initialized;

  Future<void> init() async {
    player = Player();
    controller = VideoController(player);

    try {
      // Open the video asset
      await player.open(Media('asset:///assets/start.mp4'));

      // Loop video: replay when finished
      player.stream.completed.listen((_) async {
        await player.seek(Duration.zero);
        await player.play();
      });

      await player.play();
      _initialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Home video error: $e');
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
