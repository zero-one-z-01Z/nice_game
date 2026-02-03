import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../core/navigation.dart';

class GameOverVideoProvider extends ChangeNotifier {
  late VideoPlayerController _controller;
  bool _initialized = false;

  VideoPlayerController get controller => _controller;
  bool get isInitialized => _initialized;

  Future<void> init(String path) async {
    _controller = VideoPlayerController.file(File(path));

    try {
      await _controller.initialize();
      _controller.play();
      _initialized = true;

      _controller.addListener(_videoListener);
      notifyListeners();
    } catch (e) {
      debugPrint('GameOver video error: $e');
    }
  }

  void _videoListener() {
    if (_controller.value.isInitialized &&
        _controller.value.position >= _controller.value.duration) {
      _controller.pause();
      navPU();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }
}
