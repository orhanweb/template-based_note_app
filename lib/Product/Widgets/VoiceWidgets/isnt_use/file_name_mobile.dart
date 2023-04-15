import 'package:ekin_app/Product/Widgets/VoiceWidgets/isnt_use/record_audio_vm.dart';
import 'package:path_provider/path_provider.dart';

PlatformLocation get createAdapter => MobilePlatformLocation();

class MobilePlatformLocation implements PlatformLocation {
  @override
  Future<String> getPath() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path.isNotEmpty
        ? '${directory.path}/recorded_audio'
        : '/default/path/recorded_audio.wav';
  }
}
