import 'package:ekin_app/Core/Constants/radius.dart';
import 'package:ekin_app/Core/Constants/string_const.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_cubit.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_model.dart';
import 'package:ekin_app/Product/Utils/Enums/widget_enum.dart';
import 'package:ekin_app/Product/Widgets/Atomics/empty_dotted_border.dart';
import 'package:ekin_app/Product/Widgets/ImageWidgets/Camera_Widget/camera_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraView extends StatelessWidget with CameraForMobileMixin {
  const CameraView({super.key, required this.indexinList});
  final int indexinList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewRegCubit, List<NewRegModel>>(
      builder: (context, state) {
        return EmptyDotterBorder(
            onTap: kIsWeb
                ? () {
                    pickImageForWeb(context: context, indexinList: indexinList);
                  }
                : () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: AppRadius.radius10Circular),
                            child: _customDialog(context),
                          );
                        });
                  },
            height: ProjectWidgetEnums.imageGetterWidgetHeigth.value,
            child: const Center(
                child: Icon(
              Icons.photo_camera,
              size: 30,
            )));
      },
    );
  }

  Widget _customDialog(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: TextButton(
              onPressed: () {
                pickImageForMobile(
                  context: context,
                  indexinList: indexinList,
                  isCamera: true,
                );
                Navigator.pop(context);
              },
              child: const Text(AppStrings.camera)),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
              onPressed: () {
                pickImageForMobile(
                    context: context,
                    indexinList: indexinList,
                    isCamera: false);
                Navigator.pop(context);
              },
              child: const Text(AppStrings.gallery)),
        ),
      ],
    );
  }
}
