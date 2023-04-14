import 'package:ekin_app/Core/Constants/padding_const.dart';
import 'package:ekin_app/Core/Constants/radius.dart';
import 'package:ekin_app/Core/Constants/string_const.dart';
import 'package:ekin_app/Product/Widgets/MultipleAnswerWidget/multiple_answer_view_model.dart';
import 'package:ekin_app/Product/Widgets/MultipleAnswerWidget/option_widget.dart';
import 'package:ekin_app/Product/Widgets/MultipleAnswerWidget/options_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class MultipleAnserView extends StatefulWidget {
  MultipleAnserView({super.key, required this.indexinList});
  final int indexinList;
  final List<OptionsModel> options = [];
  final TextEditingController questionController = TextEditingController();
  @override
  State<MultipleAnserView> createState() => _MultipleAnserViewState();
}

class _MultipleAnserViewState extends State<MultipleAnserView>
    with MultipleAnswerMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: context.colorScheme.inversePrimary,
          borderRadius: AppRadius.radius10Circular),
      height: height(context),
      child: Padding(
        padding: kPaddingAllSmall - kPaddingBottomSmall,
        child: Column(
          children: [
            questionField(widget.questionController),
            Expanded(
              child: ListView.builder(
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  return OptionWidget(model: widget.options[index]);
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => onPressed(context),
                child: const Text(AppStrings.addOption),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget questionField(TextEditingController questionController) {
    return TextField(
      controller: questionController,
      decoration: InputDecoration(
          hintText: AppStrings.questionhintText,
          fillColor: context.colorScheme.secondaryContainer),
      minLines: 1,
      maxLines: 2,
    );
  }
}
