import 'package:ekin_app/Product/Utils/Enums/widget_sizes_enum.dart';
import 'package:ekin_app/Product/Widgets/Atomics/empty_dotted_border.dart';
import 'package:flutter/material.dart';

class RecorderView extends StatefulWidget {
  const RecorderView({super.key});

  @override
  State<RecorderView> createState() => _RecorderViewState();
}

class _RecorderViewState extends State<RecorderView> {
  @override
  Widget build(BuildContext context) {
    return EmptyDotterBorder(
      onTap: () {},
      height: ProjectWidgetEnums.recorderAudioWidgetHeigth.value,
      child: const Icon(
        Icons.mic_none_outlined,
        size: 30,
      ),
    );
  }
}
