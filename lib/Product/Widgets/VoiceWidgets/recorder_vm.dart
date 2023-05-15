import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class SoundRecorder with ChangeNotifier {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  Duration _currentDuration = Duration.zero;
  bool _isProcessing = false;

  bool get isRecording => _isRecording;
  Duration get currentDuration => _currentDuration;
  bool get isProcessing => _isProcessing;

  void _changeProgessState() {
    _isProcessing = !_isProcessing;
    notifyListeners();
  }

  Future<void> toggleRecording(String path) async {
    if (_isRecording) {
      await _stopRecording();
    } else {
      await _startRecording(path);
    }
    notifyListeners();
  }

  Future<void> _startRecording(String path) async {
    _changeProgessState();
    await _recorder.openRecorder();
    await _recorder.startRecorder(toFile: path, codec: Codec.pcm16);

    _isRecording = true;
    _changeProgessState();
    // Süreyi izleme
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isRecording) {
        timer.cancel();
      } else {
        _currentDuration = _currentDuration + const Duration(seconds: 1);
        notifyListeners();
      }
    });
  }

  Future<void> _stopRecording() async {
    _changeProgessState();
    await _recorder.stopRecorder();
    await _recorder.closeRecorder();
    _changeProgessState();
    _isRecording = false;
    _currentDuration = Duration.zero;
  }

  @override
  Future<void> dispose() async {
    await _recorder.closeRecorder();

    super.dispose();
  }
}
