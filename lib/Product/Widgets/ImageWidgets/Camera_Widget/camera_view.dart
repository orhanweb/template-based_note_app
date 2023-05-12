import 'dart:io';

import 'package:ekin_app/Core/Constants/radius.dart';
import 'package:ekin_app/Core/Constants/string_const.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_cubit.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_model.dart';
import 'package:ekin_app/Product/Utils/Enums/widget_sizes_enum.dart';
import 'package:ekin_app/Product/Utils/Permissions/permissions.dart';
import 'package:ekin_app/Product/Widgets/Atomics/empty_dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'camera_vm.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key, required this.indexinList});
  final int indexinList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewRegCubit, List<NewRegModel>>(
      builder: (context, state) {
        return EmptyDotterBorder(
            onTap: kIsWeb
                ? () {
                    CameraForApp().pickImageForWeb().then((value) {
                      context.read<NewRegCubit>().addShowimageForWeb(
                          indexinList: indexinList, imageBytes: value);
                    });
                  }
                : () {
                    showDialog<File?>(
                        context: context,
                        builder: (context) {
                          return CustomCameraDialog();
                        }).then((value) {
                      context.read<NewRegCubit>().addShowimageWidget(
                          indexinList: indexinList, image: value);
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
}

// DIALOG MESSAGE : CAMERA OR GALLERY
class CustomCameraDialog extends StatelessWidget {
  CustomCameraDialog({super.key});
  final CameraForApp _cameraForApp = CameraForApp();
  late final File? image;

  Future<File?> _getImage(ImageSource source) async {
    bool hasPermissions = await PermissionService.checkAndRequestCamera();
    if (hasPermissions) {
      image = await _cameraForApp.pickImageForMobile(source: source);
      return image;
    } else {
      openAppSettings();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppRadius.radius10Circular),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: TextButton(
                onPressed: () async {
                  Navigator.pop(context, await _getImage(ImageSource.camera));
                },
                child: const Text(AppStrings.camera)),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
                onPressed: () async {
                  Navigator.pop(context, await _getImage(ImageSource.gallery));
                },
                child: const Text(AppStrings.gallery)),
          ),
        ],
      ),
    );
  }
}
