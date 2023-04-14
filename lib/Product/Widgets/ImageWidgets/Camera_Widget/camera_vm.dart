import 'dart:io';
import 'dart:typed_data';

import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

mixin CameraForMobileMixin on StatelessWidget {
  // get a image func
  Future<File?> _getImage({required ImageSource source}) async {
    final XFile? image = await ImagePicker().pickImage(source: source);
    if (image == null) return null;
    return File(image.path);
  }

  //Send image to Show Image View Wiget
  Future<void> pickImageForMobile(
      {required BuildContext context,
      required int indexinList,
      required bool isCamera}) async {
    bool hasPermissions = await requestPermissions(context);
    if (hasPermissions) {
      final File? image = await _getImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);

      if (context.mounted) {
        context
            .read<NewRegCubit>()
            .addShowimageWidget(indexinList: indexinList, image: image);
      }
    } else {
      if (context.mounted) showSnackBar(context);
    }
  }

  //Send image to Show Image View Wiget for WEB
  Future<void> pickImageForWeb({
    required BuildContext context,
    required int indexinList,
  }) async {
    final pickedFile =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (pickedFile != null) {
      Uint8List? imageBytes = pickedFile.files.first.bytes!;
      if (context.mounted) {
        context.read<NewRegCubit>().addShowimageForWeb(
            indexinList: indexinList, imageBytes: imageBytes);
      }
    }
  }

  // Permission Handler Camera and Stroage
  Future<bool> requestPermissions(BuildContext context) async {
    final List<Permission> permissions = [
      Permission.camera,
      Permission.storage
    ];
    final Map<Permission, PermissionStatus> permissionStatuses =
        await permissions.request();
    return permissionStatuses.values.any((status) => !status.isGranted);
  }

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Camera and Storage permissions required'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Open Settings', onPressed: () => openAppSettings())));
  }
}
