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

  static Future<bool> checkAndRequestCamera() async {
    bool isGrantedCamera = await _checkPermission(Permission.camera);
    if (!isGrantedCamera) {
      isGrantedCamera = await _requestPermission(Permission.camera);
    }
    return isGrantedCamera;
  }

  static Future<bool> checkAndRequestMic() async {
    bool isGrantedMic = await _checkPermission(Permission.microphone);

    if (!(isGrantedMic)) {
      isGrantedMic = await _requestPermission(Permission.microphone);
    }

    return isGrantedMic;
  }
}
