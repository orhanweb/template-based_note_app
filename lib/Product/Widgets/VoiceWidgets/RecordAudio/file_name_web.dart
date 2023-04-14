// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:ekin_app/Product/Widgets/VoiceWidgets/RecordAudio/record_audio_vm.dart';

PlatformLocation get createAdapter => WebPlatformLocation();

class WebPlatformLocation implements PlatformLocation {
  @override
  Future<String> getPath() async {
    final path = window.location.pathname;
    if (path == null) {
      return "/default/path/recorded_audio.wav";
    }
    final index = path.lastIndexOf('/');
    final directoryPath = path.substring(0, index);
    return '$directoryPath/recorded_audio';
  }
}
