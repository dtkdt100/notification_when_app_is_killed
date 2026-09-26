import Flutter
import UIKit
import UserNotifications

public class NotificationWhenAppIsKilledPlugin: NSObject, FlutterPlugin {

  // Singleton in order to use it in the user's AppDelegate.swift
  public static let instance = NotificationWhenAppIsKilledPlugin()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "notification_when_app_is_killed", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  private var observerAdded = false
  private var notificationTitleOnKill: String!
  private var notificationBodyOnKill: String!
  private var notificationInterruptionLevel: Int!
  private var notificationUseDefaultSound = false

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "setNotificationOnKillService":
        let args = call.arguments as! Dictionary<String, Any>

        notificationTitleOnKill = args["title"] as! String
        notificationBodyOnKill = args["description"] as! String
        notificationInterruptionLevel = args["interruptionLevel"] as! Int
        notificationUseDefaultSound = args["useDefaultSound"] as! Bool
        observerAdded = true
        result(true)
    case "cancelNotificationOnKillService":
        if observerAdded {
            notificationTitleOnKill = nil
            notificationBodyOnKill = nil
            observerAdded = false
        }
        result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  public func applicationWillTerminate() {
    // If title and body are nil, then we don't need to show notification.
    if notificationTitleOnKill == nil || notificationBodyOnKill == nil {
        return
    }

    let content = UNMutableNotificationContent()
    content.title = notificationTitleOnKill
    content.body = notificationBodyOnKill
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    if #available(iOS 15.0, *) {
        switch notificationInterruptionLevel {
            case 0:
                content.interruptionLevel = UNNotificationInterruptionLevel.passive
            case 1:
                content.interruptionLevel = UNNotificationInterruptionLevel.active
            case 2:
                content.interruptionLevel = UNNotificationInterruptionLevel.timeSensitive
            case 3:
                content.interruptionLevel = UNNotificationInterruptionLevel.critical
            default:
                break
        }
    }

    if (notificationUseDefaultSound == true) {
    content.sound = UNNotificationSound.default
    }
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
