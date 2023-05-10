import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class CameraForApp {
  Future<File?> pickImageForMobile({required ImageSource source}) async {
    final XFile? image = await ImagePicker().pickImage(source: source);
    if (image == null) return null;
    return File(image.path);
  }

  //Get image to Show Image View Wiget for WEB
  Future<Uint8List?> pickImageForWeb() async {
    final pickedFile =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (pickedFile != null) {
      Uint8List? imageBytes = pickedFile.files.first.bytes!;
      return imageBytes;
    }
    return null;
  }
}
