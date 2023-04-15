import 'dart:async';
import 'dart:typed_data';

import 'package:ekin_app/Core/Constants/duration_const.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_cubit.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_model.dart';
import 'package:ekin_app/Product/Widgets/Atomics/empty_dotted_border.dart';
import 'package:ekin_app/Product/Widgets/VoiceWidgets/sound_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class RecordAudioWidget extends StatefulWidget {
  final int indexinList;

  const RecordAudioWidget({Key? key, required this.indexinList})
      : super(key: key);

  @override
  State<RecordAudioWidget> createState() => _RecordAudioWidgetState();
}

class _RecordAudioWidgetState extends State<RecordAudioWidget> {
  final RecorderBase _audioBase = RecorderBase();
  Uint8List? _soundBytes;
  int _elapsedSeconds = 0;
  Timer? _timer;

  String formatDuration(Duration duration) {
    return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  void _startRecording() async {
    try {
      await _audioBase.startRecording();
      _timer = Timer.periodic(AppDuration.durationNormal, (timer) {
        setState(() {
          _elapsedSeconds++;
        });
      });
    } catch (e) {
      // handle error
    }
  }

  void _stopRecording(BuildContext context) async {
    try {
      _timer?.cancel();
      _soundBytes = await _audioBase.stopRecording();
      setState(() {
        _elapsedSeconds = 0;
      });
      if (_soundBytes.isNotNullOrEmpty) {
        context.read<NewRegCubit>().addAudioPlayerWidget(
            audioBytes: _soundBytes!, indexinList: widget.indexinList);
      }
      print(_soundBytes);
      // do something with the recorded bytes
    } catch (e) {
      // handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewRegCubit, List<NewRegModel>>(
      builder: (context, state) {
        return EmptyDotterBorder(
            onTap: _audioBase.isRecording
                ? () => _stopRecording(context)
                : () => _startRecording(),
            height: .08,
            child: AnimatedSwitcher(
              duration: AppDuration.durationLow,
              child: _audioBase.isRecording
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formatDuration(Duration(seconds: _elapsedSeconds)),
                          style: context.textTheme.headlineSmall,
                        ),
                        Text(
                          "Stop recording",
                          style: context.textTheme.bodyMedium,
                        )
                      ],
                    )
                  : Center(
                      child: Text(
                        "Tap to record audio",
                        style: context.textTheme.titleMedium,
                      ),
                    ),
            ));
      },
    );
  }
}
