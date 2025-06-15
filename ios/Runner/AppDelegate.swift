import UIKit
import Flutter
import workmanager
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
         // In AppDelegate.application method
        WorkmanagerPlugin.registerBGProcessingTask(withIdentifier: "task-identifier")
        UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
        // Register a periodic task in iOS 13+
        WorkmanagerPlugin.registerPeriodicTask(withIdentifier: "be.tramckrijte.workmanagerExample.iOSBackgroundAppRefresh", frequency: NSNumber(value: 20 * 60))
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
