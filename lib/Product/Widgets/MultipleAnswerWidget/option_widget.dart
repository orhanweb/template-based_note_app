import 'package:ekin_app/Core/Constants/padding_const.dart';
import 'package:ekin_app/Core/Constants/radius.dart';
import 'package:ekin_app/Product/Widgets/MultipleAnswerWidget/options_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class OptionWidget extends StatefulWidget {
  const OptionWidget({super.key, required this.model});
  final OptionsModel model;
  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.model.isCheck = !widget.model.isCheck;
        setState(() {});
      },
      child: Container(
        margin: kPaddingVerticalSmall / 2,
        padding: kPaddingAllSmall,
        alignment: Alignment.centerLeft,
        width: context.dynamicWidth(0.8),
        height: widget.model.text.length < 100 ? 50 : null,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: widget.model.isCheck
                ? Colors.green[300]
                : context.colorScheme.secondaryContainer,
            borderRadius: AppRadius.radius10Circular),
        child:
            Text(widget.model.text, style: Theme.of(context).textTheme.bodySmall
                //?.copyWith(color: CColors.kcblack87),
                ),
      ),
    );
  }
}
