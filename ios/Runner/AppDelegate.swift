import UIKit
import NewRelic
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      NRLogger.setLogLevels(NRLogLevelALL.rawValue)
        NewRelic.start(withApplicationToken:"AA517741931cdae6b41f7a298aa7fa2370f821a447-NRMA")
        NewRelic.enableCrashReporting(true)
        NewRelic.removeAllAttributes()
//      NewRelic.setAttribute("PLEASEWORKNAME", value: "PLEASEWORKVALUE")

        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let batteryChannel = FlutterMethodChannel(name: "nri.flutter", binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            //        guard call.method == "getBatteryLevel" else {
            //          result(FlutterMethodNotImplemented)
            //          return
            //        }
            
            guard let args = call.arguments as? [String : Any] else {return}
            switch call.method {
            case "getBatteryLevel":NewRelicIntegration.receiveBatteryLevel(result: result)
            case "testNRI": NewRelicIntegration.sendNewRelicEvent(result: result, name: "test-event")
            case "setStringValue": NewRelicIntegration.setStringValue(args: args, result: result)
            case "setCustomValue": NewRelicIntegration.setCustomValue(args: args, result: result)
            default: result(FlutterMethodNotImplemented)
            }
              
//            if call.method == "getBatteryLevel" {
//                receiveBatteryLevel(result: result)
//            } else if call.method == "testNRI" {
//                NewRelicIntegration.sendNewRelicEvent(result: result, name: "test-event")
//            } else {
//                result(FlutterMethodNotImplemented)
//                return
//            }
          
        })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class NewRelicIntegration {
    static func sendNewRelicEvent(result: FlutterResult, name: String) {
        let val: Bool = NewRelic.recordCustomEvent("flutterTestEvent2", name: "ios")
        NewRelic.setAttribute("flutterTestEvent3", value: 3)
        result(val)
    }
    
    static func receiveBatteryLevel(result: FlutterResult) {
      let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
//      if device.batteryState == UIDevice.BatteryState.unknown {
//        result(FlutterError(code: "UNAVAILABLE",
//                            message: "Battery level not available. Hello world",
//                            details: nil))
//      } else {
//        result(Int(device.batteryLevel * 100))
//      }
    }
    
    static func setStringValue(args: [String : Any], result: FlutterResult) {
        let name = args["name"] as? String ?? "unknownName"
        let value = args["value"] as? String ?? "unknownValue"
        let response: Bool = NewRelic.setAttribute(name, value: value)
        result(response)
    }
    
    static func setCustomValue(args: [String : Any], result: FlutterResult) {
        let type = args["type"] as? String ?? "Flutter"
        let response: Bool = NewRelic.recordCustomEvent(type)
        result(response)
    }
}
