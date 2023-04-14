import 'package:ekin_app/Core/Constants/duration_const.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_cubit.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_model.dart';
import 'package:ekin_app/Product/Widgets/Atomics/empty_dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import 'record_audio_vm.dart';

class RecordAudioWidget extends StatefulWidget {
  final int indexinList;

  const RecordAudioWidget({Key? key, required this.indexinList})
      : super(key: key);

  @override
  State<RecordAudioWidget> createState() => _RecordAudioWidgetState();
}

class _RecordAudioWidgetState extends State<RecordAudioWidget>
    with RecordAudioMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewRegCubit, List<NewRegModel>>(
      builder: (context, state) {
        return EmptyDotterBorder(
            onTap: () {
              if (isRecording) {
                stopRecording(context);
              } else {
                startRecording();
              }
            },
            height: .08,
            child: AnimatedSwitcher(
              duration: AppDuration.durationLow,
              child: isRecording
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formatDuration(Duration(seconds: elapsedSeconds)),
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
