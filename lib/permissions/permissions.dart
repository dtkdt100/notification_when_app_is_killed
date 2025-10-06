import 'package:permission_handler/permission_handler.dart';

class Permissions {
  /// Given a permission status, checks if notification permissions are granted
  ///
  /// Returns true if permission is granted, false otherwise.
  static bool statusNotificationPermissionGranted(
      PermissionStatus permissionStatus) {
    return permissionStatus.isGranted ||
        permissionStatus.isLimited ||
        permissionStatus.isProvisional;
  }

  /// Checking if notification permissions are granted
  ///
  /// Returns true if permission is granted, false otherwise.
  static Future<bool> isNotificationPermissionGranted() async {
    var permissionStatus = await Permission.notification.status;
    return statusNotificationPermissionGranted(permissionStatus);
  }

  /// Requesting notification permissions
  ///
  /// Returns true if permission is granted, false otherwise.
  static Future<bool> requestNotificationPermissions() async {
    bool isNotificationGranted = await isNotificationPermissionGranted();
    if (isNotificationGranted) {
      return true;
    }
    isNotificationGranted = statusNotificationPermissionGranted(
        await Permission.notification.request());
    return isNotificationGranted;
  }
}
