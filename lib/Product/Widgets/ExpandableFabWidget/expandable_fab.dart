import 'package:ekin_app/Core/Constants/string_const.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_cubit.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_model.dart';
import 'package:ekin_app/Product/Utils/Enums/widgets_enum.dart';
import 'package:ekin_app/Product/Widgets/Atomics/atom_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:kartal/kartal.dart';

class CExpandableFabWidget extends StatelessWidget {
  const CExpandableFabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewRegCubit, List<NewRegModel>>(
      builder: (context, state) {
        return ExpandableFab(
          openButtonHeroTag: "openingNewReg",
          closeButtonHeroTag: "closingNewReg",
          distance: 70,
          closeButtonStyle: ExpandableFabCloseButtonStyle(
              backgroundColor: context.colorScheme.outlineVariant,
              child: const Icon(Icons.more_vert_outlined)),
          type: ExpandableFabType.up,
          child: const Icon(
            Icons.more_horiz_outlined,
            size: 40,
          ),
          children: [
            // Add Camera Widget Button
            FloatingActionButton.small(
              heroTag: WhichWidget.camera,
              onPressed: () {
                context.read<NewRegCubit>().addCameraWidget();
              },
              child: const Icon(Icons.camera_alt_outlined),
            ),
            // Add text field button
            FloatingActionButton.small(
              heroTag: WhichWidget.text,
              onPressed: () async {
                final String? labelText = await showDialog(
                    context: context,
                    builder: (context) {
                      return AtomAlertWidget(
                        maxLength: 30,
                        title: AppStrings.alertWidgetTitle,
                      );
                    });
                if (context.mounted && labelText.isNotNullOrNoEmpty) {
                  context
                      .read<NewRegCubit>()
                      .addTextWidget(labelText: labelText!);
                }
              },
              child: const Icon(Icons.text_format_outlined),
            ),
            // Add Multiple Choice Widget
            FloatingActionButton.small(
              heroTag: WhichWidget.multipleAnswer,
              onPressed: () {
                context.read<NewRegCubit>().addMultipleAnserWidget();
              },
              child: const Icon(Icons.list_outlined),
            ),
            // Add Voice Recorder Widget
            FloatingActionButton.small(
              heroTag: WhichWidget.voiceRecorder,
              onPressed: () {
                context.read<NewRegCubit>().addVoiceRecorderWidget();
              },
              child: const Icon(Icons.mic_none),
            )
          ],
        );
      },
    );
  }
}
