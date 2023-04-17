import 'dart:async';
import 'dart:developer';
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

  Future<void> startRecording() async {
    try {
      _stream =
          await window.navigator.mediaDevices?.getUserMedia({'audio': true});

      if (_stream == null) {
        throw Exception('Failed to get user media stream');
      }
      print("ffffffffff");

      _recorder = MediaRecorder(_stream!, {'mimeType': 'audio/wav'});
      print("llllllllll");
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
