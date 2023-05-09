import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> _requestPermission(Permission permission) async {
    PermissionStatus status = await permission.request();
    return status.isGranted;
  }

  static Future<bool> _checkPermission(Permission permission) async {
    PermissionStatus status = await permission.status;
    return status.isGranted;
  }

  static Future<bool> _checkAllPermissions() async {
    bool cameraPermissionGranted = await _checkPermission(Permission.camera);
    bool storagePermissionGranted = await _checkPermission(Permission.storage);

    return cameraPermissionGranted && storagePermissionGranted;
  }

  static Future<bool> checkAndRequestCamStroage() async {
    bool allPermissionsGranted = await _checkAllPermissions();

    if (!allPermissionsGranted) {
      // İzinler verilmemiş, izinleri talep et
      bool cameraPermissionGranted =
          await _requestPermission(Permission.camera);
      bool storagePermissionGranted =
          await _requestPermission(Permission.storage);

      // Talep sonrası izinleri kontrol et
      allPermissionsGranted =
          cameraPermissionGranted && storagePermissionGranted;
    }

    return allPermissionsGranted;
  }
}
