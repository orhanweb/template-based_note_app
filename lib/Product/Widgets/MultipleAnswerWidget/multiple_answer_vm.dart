import 'package:ekin_app/Core/Constants/string_const.dart';
import 'package:ekin_app/Product/Utils/Enums/widget_enum.dart';
import 'package:ekin_app/Product/Widgets/MultipleAnswerWidget/multiple_anser_view.dart';
import 'package:ekin_app/Product/Widgets/MultipleAnswerWidget/options_widget_model.dart';
import 'package:ekin_app/Product/Widgets/Atomics/atom_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

mixin MultipleAnswerMixin on State<MultipleAnserView> {
  OptionsModel addOptionToList(String text, int index) {
    return OptionsModel(text: text, index: index, isCheck: false);
  }

  void onPressed(BuildContext context) async {
    final String? option = await showDialog(
      context: context,
      builder: (context) {
        return AtomAlertWidget(
          title: AppStrings.addOption,
          maxLength: 300,
          maxLines: 7,
        );
      },
    );
    if (option.isNotNullOrNoEmpty) {
      widget.options.add(addOptionToList(option!, widget.indexinList));
      setState(() {});
    }
  }

  double height(BuildContext context) {
    if (widget.options.length < 5) {
      return ProjectWidgetEnums.multipleAnswerWidgetHeight.value +
          (widget.options.length * 60);
    } else {
      return ProjectWidgetEnums.multipleAnswerWidgetHeight.value + 300;
    }
  }
}
