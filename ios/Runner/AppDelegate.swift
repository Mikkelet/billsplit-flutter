import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      // Register for remote notifications
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self
      }

      let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)

      // IMPORTANT: Force registration for remote notifications
      // This is necessary for iOS to send the APNS token
      application.registerForRemoteNotifications()

      return result
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
    
    // caleld when APNS token is received
    override func application(_ application: UIApplication,
                              didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      print("APNS token successfully received")
      super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    // called when there's a failure to register to remote notif
    override func application(_ application: UIApplication,
                              didFailToRegisterForRemoteNotificationsWithError error: Error) {
      super.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
      print(" Failed to register remote notifications: \(error.localizedDescription)")
    }
}
