import UIKit
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let flutterViewController = FlutterSupportViewController()
    flutterViewController.delegate = self
    addFlutterSupportViewController(from: flutterViewController)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
