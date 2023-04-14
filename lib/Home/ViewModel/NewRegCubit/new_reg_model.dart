import 'package:ekin_app/Product/Utils/Enums/widgets_enum.dart';
import 'package:flutter/material.dart';

class NewRegModel {
  final int indexinList;
  final WhichWidget widgetType;
  final Widget widget;

  NewRegModel({
    required this.indexinList,
    required this.widgetType,
    required this.widget,
  });
}
