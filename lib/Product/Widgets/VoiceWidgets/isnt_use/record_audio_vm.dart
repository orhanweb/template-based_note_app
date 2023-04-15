import 'dart:async';
import 'dart:developer';

import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_cubit.dart';
import 'package:ekin_app/Product/Widgets/VoiceWidgets/record_audio_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'file_name_mobile.dart' if (dart.library.html) 'file_name_web.dart'
    // ignore: library_prefixes
    as platformLocation;

mixin RecordAudioMixin on State<RecordAudioWidget> {
  late FlutterSoundRecorder _recorder;
  bool _isRecording = false;
  String? _recordedFilePath;
  Timer? _timer;
  int _elapsedSeconds = 0;

  // GETTERS FOR ENCAPSULATION
  bool get isRecording => _isRecording;
  int get elapsedSeconds => _elapsedSeconds;

  @override
  void initState() {
    super.initState();

    _recorder = FlutterSoundRecorder();
    _initializeRecorder();
  }

  // MOBILE FUNCS
  Future<void> _initializeRecorder() async {
    try {
      await _recorder.openRecorder();
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<bool> _requestPermission() async {
    final status = await Permission.microphone.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else if (status == PermissionStatus.denied) {
      showToast("Microphone permission denied");
    } else if (status == PermissionStatus.permanentlyDenied) {
      showToast("Microphone permission permanently denied");
      openAppSettings();
    }
    return false;
  }

  Future<void> startRecording() async {
    bool hasPermission = await _requestPermission();
    if (hasPermission) {
      try {
        final PlatformLocation platform = platformLocation.createAdapter;

        final filePath = await platform.getPath();

        await _recorder.startRecorder(
            toFile: filePath, codec: Codec.defaultCodec);

        setState(() {
          _isRecording = true;
        });

        _timer = Timer.periodic(const Duration(seconds: 1), (_) {
          setState(() {
            _elapsedSeconds += 1;
          });
        });
      } catch (e) {
        log('Error: $e');
      }
    } else {
      showToast("Record audio permission not granted");
    }
  }

  Future<void> stopRecording(BuildContext context) async {
    try {
      _recordedFilePath = await _recorder.stopRecorder();
      log(_recordedFilePath!);
      setState(() {
        _isRecording = false;
        _timer?.cancel();
      });
      if (mounted) {
        // context.read<NewRegCubit>().addAudioPlayerWidget(
        //     indexinList: widget.indexinList,
        //     audioPath: _recordedFilePath,
        //     audioDuration: elapsedSeconds);
      }
    } catch (e) {
      log('Error: $e');
    }
  }
  // ENDS OF THE MOBILE FUNCS

  String formatDuration(Duration duration) {
    return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // @override
  // void dispose() {
  //   _recorder.closeRecorder();
  //   _timer?.cancel();
  //   super.dispose();
  // }
}

abstract class PlatformLocation {
  Future<String> getPath();
}
