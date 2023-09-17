import Flutter
import UIKit

public class NotificationWhenAppIsKilledPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "notification_when_app_is_killed", binaryMessenger: registrar.messenger())
    let instance = NotificationWhenAppIsKilledPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  private var observerAdded = false

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "setNotificationOnKillService":
        let args = call.arguments as! Dictionary<String, Any>

        notificationTitleOnKill = args["title"] as! String
        notificationBodyOnKill = args["description"] as! String

        observerAdded = true
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillTerminate(_:)), name: UIApplication.willTerminateNotification, object: nil)

        result("iOS " + UIDevice.current.systemVersion)
    case "cancelNotificationOnKillService":
        if observerAdded {
            NotificationCenter.default.removeObserver(self, name: UIApplication.willTerminateNotification, object: nil)
            observerAdded = false
        }
        result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  @objc func applicationWillTerminate(_ notification: Notification) {
          let content = UNMutableNotificationContent()
          content.title = notificationTitleOnKill
          content.body = notificationBodyOnKill
          let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
          let request = UNNotificationRequest(identifier: "notification on app kill", content: content, trigger: trigger)

          UNUserNotificationCenter.current().add(request) { (error) in
              if let error = error {
                  NSLog("SwiftAlarmPlugin: Failed to show notification on kill service => error: \(error.localizedDescription)")
              } else {
                  NSLog("SwiftAlarmPlugin: Show notification on kill now")
              }
          }
      }
}
