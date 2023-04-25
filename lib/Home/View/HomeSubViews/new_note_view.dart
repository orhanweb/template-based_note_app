import 'package:ekin_app/Core/Constants/padding_const.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_cubit.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_model.dart';
import 'package:ekin_app/Product/Widgets/ExpandableFabWidget/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class NewNoteView extends StatelessWidget {
  const NewNoteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<NewRegCubit, List<NewRegModel>>(
            builder: (context, state) {
          return ListView.builder(
              padding: kPaddingTopMedium,
              itemCount: state.length,
              itemBuilder: (context, index) => Padding(
                  padding: kPaddingHorizontalLarge + kPaddingBottomMedium,
                  child: state[index].widget));
        }),
        floatingActionButton: const CExpandableFabWidget(),
        floatingActionButtonLocation: ExpandableFab.location);
  }
}
