import 'package:permission_handler/permission_handler.dart';

abstract class IPermissionChecker {
  Future<bool> checkMediaPermisson();
}

class AppPermissons implements IPermissionChecker {
  @override
  Future<bool> checkMediaPermisson() async {
    final status = await Permission.camera.status;
    return status.isDenied;
  }
}
