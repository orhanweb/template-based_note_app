import 'dart:async';
import 'dart:developer';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';

import 'package:ekin_app/Core/Constants/duration_const.dart';
import 'package:flutter/services.dart';

class RecorderBase {
  MediaStream? _stream;
  MediaRecorder? _recorder;
  // ignore: prefer_final_fields
  List<Uint8List> _chunks = [];
  bool isRecording = false;
  int _countDownLoadChunks = 0;
  void init() async {
    try {
      dispose();
      _stream =
          await window.navigator.mediaDevices?.getUserMedia({'audio': true});
      _recorder = MediaRecorder(_stream!);
    } catch (e) {
      throw Exception('Recorder Base failed to initialize.');
    }
  }

  Future<void> startRecording() async {
    try {
      if (_stream == null || _recorder == null) {
        init();
        throw Exception(
            'Failed to get user media stream and recorder didnt connect to stream');
      }

      _recorder?.start();
      isRecording = true;
      _recorder?.addEventListener('dataavailable', (event) async {
        final reader = FileReader();
        reader.readAsArrayBuffer((event as BlobEvent).data!);
        await reader.onLoad.first;
        final buffer = reader.result as Uint8List?;
        if (buffer == null) {
          throw Exception('Failed to read data available from media recorder');
        }
        _chunks.add(buffer);
        print("object11");
      });
    } catch (e) {
      log('Error while starting audio recording: $e');
      init();
      rethrow;
    }
  }

  Future<Uint8List?> stopRecording() async {
    try {
      if (_recorder == null || _stream == null) {
        init();
        throw Exception('Media recorder is not available');
      }
      _recorder?.stop();
      _stream?.getTracks().forEach((track) => track.stop());

      while (_chunks.isEmpty && _countDownLoadChunks <= 5) {
        _countDownLoadChunks++;
        await Future.delayed(AppDuration.durationNormal);
      }
      isRecording = false;
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

  void dispose() {
    try {
      _recorder?.stop();
      _stream?.getTracks().forEach((track) => track.stop());
      _chunks.clear();
      isRecording = false;
      _recorder = null;
      _stream = null;
    } catch (e) {
      log('Error while disposing audio recording: $e');
      rethrow;
    }
  }
}
