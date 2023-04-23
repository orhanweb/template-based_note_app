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

  Future<bool> startRecording() async {
    try {
      _stream =
          await window.navigator.mediaDevices?.getUserMedia({'audio': true});

      _recorder = MediaRecorder(_stream!);
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
      });
      return true;
    } catch (e) {
      log('Error while starting audio recording: $e');
      dispose();
      // add remove method later
      return false;
    }
  }

  Future<Uint8List?> stopRecording() async {
    try {
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
      // add remove method later
      log('Error while stopping audio recording: $e');
      rethrow;
    }
  }

  void dispose() {
    try {
      if (_recorder != null && _recorder?.state == 'recording') {
        _recorder?.stop();
        _recorder = null;
      }
      _stream?.getTracks().forEach((track) => track.stop());
      _chunks.clear();
      isRecording = false;
      _stream = null;
    } catch (e) {
      log('Error while disposing audio recording: $e');
      rethrow;
    }
  }
}
