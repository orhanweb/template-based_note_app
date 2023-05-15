import 'package:ekin_app/Product/Utils/Enums/widget_sizes_enum.dart';
import 'package:ekin_app/Product/Widgets/Atomics/empty_dotted_border.dart';
import 'package:ekin_app/Product/Widgets/VoiceWidgets/recorder_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecorderView extends StatelessWidget {
  const RecorderView({super.key, required this.indexinList});
  final int indexinList;

  final String path = "";
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SoundRecorder>(
      create: (_) => SoundRecorder(),
      child: Consumer<SoundRecorder>(
        builder: (context, recorder, child) {
          return EmptyDotterBorder(
            onTap: recorder.isProcessing
                ? null
                : () async {
                    await recorder.toggleRecording(path);
                  },
            height: 400, //ProjectWidgetEnums.recorderAudioWidgetHeigth.value,
            child: Column(
              children: [
                Text(recorder.isRecording ? 'Kayıt Yapılıyor' : 'Kayıt Başlat'),
                Text(
                    'Kayıt Süresi: ${recorder.currentDuration.inSeconds} saniye'),
                const Icon(
                  Icons.mic_none_outlined,
                  size: 30,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SoundRecordingWidget extends StatelessWidget {
  final String path;

  const SoundRecordingWidget({super.key, this.path = ""});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SoundRecorder>(
      create: (_) => SoundRecorder(),
      child: Consumer<SoundRecorder>(
        builder: (context, recorder, child) {
          return EmptyDotterBorder(
            onTap: () {
              recorder.isRecording
                  ? null
                  : () => recorder.toggleRecording(path);
            },
            height: ProjectWidgetEnums.recorderAudioWidgetHeigth.value,
            child: Column(
              children: [
                Text(recorder.isRecording ? 'Kayıt Yapılıyor' : 'Kayıt Başlat'),
                Text(
                    'Kayıt Süresi: ${recorder.currentDuration.inSeconds} saniye'),
                const Icon(
                  Icons.mic_none_outlined,
                  size: 30,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
