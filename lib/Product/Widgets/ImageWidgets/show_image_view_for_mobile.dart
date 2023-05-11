import 'dart:io';

import 'package:ekin_app/Core/Constants/padding_const.dart';
import 'package:ekin_app/Core/Constants/radius.dart';
import 'package:ekin_app/Core/Constants/string_const.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_cubit.dart';
import 'package:ekin_app/Product/Widgets/ImageWidgets/show_image_vm_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class ShowImageView extends StatefulWidget {
  const ShowImageView(
      {Key? key, required this.image, required this.indexinList})
      : super(key: key);
  final File image;
  final int indexinList;
  @override
  State<ShowImageView> createState() => _ShowImageViewState();
}

class _ShowImageViewState extends State<ShowImageView> with ShowImageMixin {
  @override
  void initState() {
    super.initState();
    image = widget.image;
  }

  @override
  void dispose() {
    widget.image.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: AppRadius.radius12Circular,
          color: context.colorScheme.inversePrimary),
      child: SizedBox(
        height: controller.text.isEmpty
            ? context.dynamicHeight(0.3)
            : context.dynamicHeight(0.5),
        child: Stack(
          children: [
            Column(
              children: [
                _ImageWidget(image: image),
                controller.text.isNotEmpty
                    ? SizedBox(
                        width: context.dynamicWidth(0.8),
                        child: TextField(
                          maxLines: 5,
                          controller: controller,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: kPaddingRightMedium,
                child: _imageProcesses(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageProcesses() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        IconButton(
          tooltip: AppStrings.cropImage,
          onPressed: () async {
            await croppedImage(imagesource: widget.image);
          },
          icon: const Icon(Icons.crop_outlined),
        ),
        IconButton(
            tooltip: AppStrings.textOnImage,
            onPressed: isLoading
                ? null
                : () async {
                    getTextOnImage(image: widget.image);
                  },
            icon: isLoading
                ? const CircularProgressIndicator.adaptive(strokeWidth: 2)
                : const Icon(Icons.text_snippet_rounded)),
        BlocBuilder<NewRegCubit, List>(
          builder: (context, state) {
            return IconButton(
              tooltip: AppStrings.refresh,
              onPressed: () {
                context
                    .read<NewRegCubit>()
                    .backtoCameraWidget(indexinList: widget.indexinList);
              },
              icon: const Icon(Icons.refresh_rounded),
            );
          },
        ),
      ],
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({required this.image});

  final File image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.23),
      margin: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 35,
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: AppRadius.radius12Circular,
          child: Image.file(image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
