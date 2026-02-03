import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class QuestionVideoProvider extends ChangeNotifier {
  late VideoPlayerController _controller;
  bool _initialized = false;

  VideoPlayerController get controller => _controller;
  bool get isInitialized => _initialized;

  Future<void> init() async {
    _controller = VideoPlayerController.asset('assets/background.mp4');

    try {
      await _controller.initialize();
      await _controller.setLooping(true);
      await _controller.play();

      _initialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Question video init error: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
