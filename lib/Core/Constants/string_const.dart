import 'package:flutter/material.dart';

@immutable
class AppStrings {
  const AppStrings._();
  // Main App Strings
  static const String mainAppBarString = 'Ekin';
  static const String newNote = "New Note";
  static const String saved = "Saved";
  static const String templates = "Templates";

  // Drop Zone Strings
  static const String message = 'Tap for add a image';
  static const String onLeaveMessage = "Dont be afraid";
  static const String onHowerMessage = "You can drop";
  static const String onDropMultipleMessage = "You can drop only one image ";

  // Camera Widget Strings
  static const String camera = 'Camera';
  static const String gallery = "Gallery";
  static const String pictureAlertDialogTitle = "Add Picture";
  static const String requiredPermissionFailedText =
      'Camera and Storage permissions required';

  // ShowImage floating action buttons tool tip text
  static const String cropImage = "Resmi Kırp";
  static const String textOnImage = "Resimdeki Yazıyı Çıkar";
  static const String refresh = 'Yeniden';

  // Multiple answer strings
  static const String addOption = "+ Add Option"; //same time alert widget title
  static const String questionhintText = "Question?";

  // Text Input Strings
  static const String alertWidgetTitle = "Add Label of Text Field";

  // Custom Alert Widget Button Text
  static const String alertButtonText = "Add";
}
