import 'package:ekin_app/Core/Constants/padding_const.dart';
import 'package:ekin_app/Core/Constants/string_const.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CSliverAppbar extends StatelessWidget {
  const CSliverAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(AppStrings.mainAppBarString,
          style: context.textTheme.headlineMedium),
      pinned: false,
      snap: true,
      floating: true,
      centerTitle: true,
      bottom: const TabBar(
        indicatorPadding: kPaddingAllSmall,
        tabs: [
          Tab(text: AppStrings.newNote),
          Tab(text: AppStrings.saved),
          Tab(text: AppStrings.templates)
        ],
      ),
    );
  }
}
