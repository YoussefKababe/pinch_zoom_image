import Flutter
import UIKit

public class SwiftPinchZoomImagePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "pinch_zoom_image", binaryMessenger: registrar.messenger())
    let instance = SwiftPinchZoomImagePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "hideStatusBar") {
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar
        result(nil)
    } else if (call.method == "showStatusBar") {
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
        result(nil)
    }
  }
}
