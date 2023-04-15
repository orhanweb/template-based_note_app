import 'dart:async';
import 'dart:developer';
import 'dart:html';
import 'dart:typed_data';

import 'package:ekin_app/Core/Constants/duration_const.dart';
import 'package:flutter/services.dart';

class AudioPlayer {
  AudioPlayer() {
    _audioPlayerChannel.setMethodCallHandler(_audioPlayerMethodCallHandler);
  }

  static const MethodChannel _audioPlayerChannel =
      MethodChannel('audio_player');
  StreamController<AudioPlayerState> _playerStateController =
      StreamController<AudioPlayerState>.broadcast();
  Stream<AudioPlayerState> get onPlayerStateChanged =>
      _playerStateController.stream;

  Future<void> play(Uint8List data) async {
    try {
      await _audioPlayerChannel.invokeMethod<void>('play', data);
    } on PlatformException catch (e) {
      throw AudioPlayerException(e.message);
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayerChannel.invokeMethod<void>('pause');
    } on PlatformException catch (e) {
      throw AudioPlayerException(e.message);
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayerChannel.invokeMethod<void>('stop');
    } on PlatformException catch (e) {
      throw AudioPlayerException(e.message);
    }
  }

  Future<int?> getDuration() async {
    try {
      return await _audioPlayerChannel.invokeMethod<int>('getDuration');
    } on PlatformException catch (e) {
      throw AudioPlayerException(e.message);
    }
  }

  Future<int?> getCurrentPosition() async {
    try {
      return await _audioPlayerChannel.invokeMethod<int>('getCurrentPosition');
    } on PlatformException catch (e) {
      throw AudioPlayerException(e.message);
    }
  }

  Future<void> seekTo(int milliseconds) async {
    try {
      await _audioPlayerChannel.invokeMethod<void>('seekTo', milliseconds);
    } on PlatformException catch (e) {
      throw AudioPlayerException(e.message);
    }
  }

  Future<void> dispose() async {
    try {
      _playerStateController.close();
      await _audioPlayerChannel.invokeMethod<void>('dispose');
    } on PlatformException catch (e) {
      throw AudioPlayerException(e.message);
    }
  }

  Future<dynamic> _audioPlayerMethodCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onPlayerStateChanged':
        _playerStateController
            .add(AudioPlayerState.values[call.arguments['state']]);
        break;
    }
  }
}

class AudioPlayerException implements Exception {
  final String? message;

  AudioPlayerException(this.message);
}

enum AudioPlayerState {
  stopped,
  playing,
  paused,
  completed,
}

// _____________________---------------------------_______________________----------------------
class RecorderBase {
  MediaStream? _stream;
  MediaRecorder? _recorder;
  // ignore: prefer_final_fields
  List<Uint8List> _chunks = [];
  bool isRecording = false;
  int _countDownLoadChunks = 0;

  Future<void> startRecording() async {
    try {
      _stream =
          await window.navigator.mediaDevices?.getUserMedia({'audio': true});

      if (_stream == null) {
        throw Exception('Failed to get user media stream');
      }

      _recorder = MediaRecorder(_stream!);
      _recorder!.addEventListener('dataavailable', (event) async {
        final reader = FileReader();
        reader.readAsArrayBuffer((event as BlobEvent).data!);

        await reader.onLoad.first;
        final buffer = reader.result as Uint8List?;

        if (buffer == null) {
          throw Exception('Failed to read data available from media recorder');
        }

        _chunks.add(buffer);
      });

      _recorder!.start();
      isRecording = true;
    } catch (e) {
      log('Error while starting audio recording: $e');
      rethrow;
    }
  }

  Future<Uint8List?> stopRecording() async {
    try {
      if (_recorder == null) {
        throw Exception('Media recorder is not available');
      }
      isRecording = false;
      _recorder?.stop();

      _stream?.getTracks().forEach((track) => track.stop());
      while (_chunks.isEmpty && _countDownLoadChunks <= 5) {
        _countDownLoadChunks++;
        await Future.delayed(AppDuration.durationNormal);
      }

      if (_chunks.isEmpty) {
        _countDownLoadChunks = 0;
        return null;
      }

      final bytes =
          Uint8List.fromList(_chunks.expand((chunk) => chunk).toList());
      _chunks.clear();

      return bytes;
    } catch (e) {
      log('Error while stopping audio recording: $e');
      rethrow;
    }
  }
}
