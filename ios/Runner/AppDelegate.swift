import UIKit
import Flutter
import FirebaseCore
import flutter_local_notifications
import StripeApplePay

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    // This is required to make any communication available in the action isolate.
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }
    StripeAPI.defaultPublishableKey = "pk_test_51NBGrSG1aZCtR7k22nyDEZF5b6TnRaIITOvdjDlGSgefCvwEMpultKcCDZpYqQiqaIsy0ggmlEXHvwqztuwfiuH600z8kcalG1"

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
