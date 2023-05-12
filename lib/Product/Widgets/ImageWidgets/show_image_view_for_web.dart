import 'dart:typed_data';
import 'package:ekin_app/Core/Constants/padding_const.dart';
import 'package:ekin_app/Core/Constants/radius.dart';
import 'package:ekin_app/Core/Constants/string_const.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_cubit.dart';
import 'package:ekin_app/Product/Utils/Enums/widget_sizes_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class ShowImageViewWeb extends StatelessWidget {
  const ShowImageViewWeb(
      {super.key, required this.imageBytes, required this.indexinList});
  final Uint8List imageBytes;
  final int indexinList;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: AppRadius.radius12Circular,
          color: context.colorScheme.inversePrimary),
      height: ProjectWidgetEnums.imageShowerWidgetHeigth.value,
      child: Stack(
        children: [
          _showImage(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: kPaddingBottomMedium,
              child: BlocBuilder<NewRegCubit, List>(
                builder: (context, state) {
                  return IconButton(
                    tooltip: AppStrings.refresh,
                    onPressed: () {
                      context
                          .read<NewRegCubit>()
                          .backtoCameraWidget(indexinList: indexinList);
                    },
                    icon: const Icon(Icons.refresh_rounded),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _showImage(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                FullScreenImageView(imageBytes)));
      },
      child: Container(
        margin: kPaddingVerticalMedium,
        child: Center(
          child: ClipRRect(
            borderRadius: AppRadius.radius12Circular,
            child: Image.memory(
              imageBytes,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  const FullScreenImageView(this.imageBytes, {super.key});

  final Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Image.memory(imageBytes),
        ),
      ),
    );
  }
}
