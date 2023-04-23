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
  late final RecorderBase _audioBase;
  Uint8List? _soundBytes;
  int _elapsedSeconds = 0;
  Timer? _timer;
  bool _isBusy = false;

  String formatDuration(Duration duration) {
    return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _audioBase = RecorderBase();
  }

  void _busyChange() {
    setState(() => _isBusy = !_isBusy);
  }

  void _startRecording() async {
    _busyChange();
    bool isStarting = await _audioBase.startRecording();
    if (isStarting) {
      _timer = Timer.periodic(AppDuration.durationNormal,
          (timer) => setState(() => _elapsedSeconds++));
    }

    _busyChange();
  }

  void _stopRecording(BuildContext context) async {
    _busyChange();
    _soundBytes = await _audioBase.stopRecording();

    // ignore: use_build_context_synchronously
    context.read<NewRegCubit>().addAudioPlayerWidget(
        audioData: _soundBytes, indexinList: widget.indexinList);

    _busyChange();
    _timer?.cancel();
    _audioBase.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewRegCubit, List<NewRegModel>>(
        builder: (context, state) {
      return EmptyDotterBorder(
          onTap: _isBusy
              ? null
              : _audioBase.isRecording
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
                              formatDuration(
                                  Duration(seconds: _elapsedSeconds)),
                              style: context.textTheme.headlineSmall),
                          Text("Stop recording",
                              style: context.textTheme.bodyMedium)
                        ])
                  : Center(
                      child: Text("Tap to record audio",
                          style: context.textTheme.titleMedium))));
    });
  }
}
