import Flutter
import UIKit
// This is required for calling FlutterLocalNotificationsPlugin.setPluginRegistrantCallback method.
import flutter_local_notifications
import workmanager_apple
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // This is required to make any communication available in the action isolate.
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    let dartDefinesString = Bundle.main.infoDictionary!["DART_DEFINES"] as! String
    var dartDefinesDictionary = [String:String]()
    for definedValue in dartDefinesString.components(separatedBy: ",") {
      let decoded = String(data: Data(base64Encoded: definedValue)!, encoding: .utf8)!
      let values = decoded.components(separatedBy: "=")
      dartDefinesDictionary[values[0]] = values[1]
    }
    GMSServices.provideAPIKey(dartDefinesDictionary["MAPS_API_KEY"]!)

    GeneratedPluginRegistrant.register(with: self)

    // Option 1: Notification-based debug handler (shows debug info as notifications)
    WorkmanagerDebug.setCurrent(NotificationDebugHandler())
    WorkmanagerPlugin.setPluginRegistrantCallback { registry in
      // Registry in this case is the FlutterEngine that is created in Workmanager's
      // performFetchWithCompletionHandler or BGAppRefreshTask.
      // This will make other plugins available during a background operation.
      GeneratedPluginRegistrant.register(with: registry)
    }
    WorkmanagerPlugin.registerPeriodicTask(
        withIdentifier: "subscription-periodic-task",
        frequency: NSNumber(value: 24 * 60 * 60) // Every 24 hours
    )

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func userNotificationCenter(
      _ center: UNUserNotificationCenter,
      willPresent notification: UNNotification,
      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler(.alert) // shows banner even if app is in foreground
  }
}
