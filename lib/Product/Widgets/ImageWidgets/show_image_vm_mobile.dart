import 'dart:developer';
import 'dart:io';

import 'package:ekin_app/Product/Widgets/ImageWidgets/show_image_view_for_mobile.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';

mixin ShowImageMixin on State<ShowImageView> {
  final TextEditingController controller = TextEditingController();
  late File image;
  bool isLoading = false;
  // CROPPED IMAGE only mobile for now
  Future<void> croppedImage({
    required File imagesource,
  }) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imagesource.path);
    if (croppedImage == null) return;
    File? croppedImageFile = File(croppedImage.path);

    setState(() {
      image = croppedImageFile;
    });
  }

  // GET TEXT ON IMAGE only mobile for now
  Future<void> getTextOnImage({required File image}) async {
    _loadingFindText();
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    if (recognizedText.text.isNotEmpty) {
      setState(() {
        controller.text = recognizedText.text;
      });
    } else {
      log("Yazı bulunamadı");
    }
    _loadingFindText();
  }

  // Loading find text on image
  void _loadingFindText() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
