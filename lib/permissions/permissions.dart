import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static bool isNotificationPermissionGrantedSync(PermissionStatus permissionStatus) {
    return permissionStatus.isGranted || permissionStatus.isLimited || permissionStatus.isProvisional;
  }

  static Future<bool> isNotificationPermissionGranted() async {
    var permissionStatus = await Permission.notification.status;
    return isNotificationPermissionGrantedSync(permissionStatus);
  }

  static Future<bool> requestNotificationPermissions() async {
    bool isNotificationGranted = await isNotificationPermissionGranted();
    if (isNotificationGranted) {
      return true;
    }
    isNotificationGranted = isNotificationPermissionGrantedSync(await Permission.notification.request());
    return isNotificationGranted;
  }
}
