import UIKit
import NewRelic
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
        NewRelic.start(withApplicationToken:"AA517741931cdae6b41f7a298aa7fa2370f821a447-NRMA")
        NewRelic.enableCrashReporting(true)

        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let batteryChannel = FlutterMethodChannel(name: "samples.flutter.dev/battery",
                                                binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            //        guard call.method == "getBatteryLevel" else {
            //          result(FlutterMethodNotImplemented)
            //          return
            //        }
            guard let args = call.arguments as? [String : Any] else {return}
                        
            switch call.method {
            case "getBatteryLevel": NewRelicIntegration.receiveBatteryLevel(result: result)
            case "testNRI": NewRelicIntegration.sendNewRelicEvent(result: result, name: "test-event")
            case "setStringValue": NewRelicIntegration.setStringValue(args: args, result: result)
            case "setDoubleValue": NewRelicIntegration.setDoubleValue(args: args, result: result)
            case "setBoolValue": NewRelicIntegration.setBoolValue(args: args, result: result)
            case "incrementValue": NewRelicIntegration.incrementValue(args: args, result: result)
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
    
    static func setStringValue(args: [String:Any], result: FlutterResult){
        let name = args["name"] as? String ?? "String not found"
        let value = args["value"] as? String ?? "Value not found"
        let response: Bool = NewRelic.setAttribute(name, value: value)
        result(response)
        
    }
    
    static func setIntValue(args: [String:Any], result: FlutterResult){
     let name = args["name"] as? String ?? "String not found"
     let value: Int = args["value"] as! Int
     let response: Bool = NewRelic.setAttribute(name, value: value)
     result(response)
    }
    
    static func setDoubleValue(args: [String:Any], result: FlutterResult){
     let name = args["name"] as? String ?? "String not found"
     let value: Double = args["value"] as! Double
     let response: Bool = NewRelic.setAttribute(name, value: value)
     result(response)
    }
    
    static func setBoolValue(args: [String:Any], result: FlutterResult){
     let name = args["name"] as? String ?? "String not found"
     let value: Bool = args["value"] as! Bool
     let response: Bool = NewRelic.setAttribute(name, value: value)
     result(response)
    }
    
    static func incrementValue(args: [String:Any], result: FlutterResult){
     let name = args["name"] as? String ?? "String not found"
     let value = args["value"] as? String ?? "Value not found"
     let response: Bool = NewRelic.setAttribute(name, value: value)
     result(response)
    }
    
    static func setCustomValue(args: [String : Any], result: FlutterResult) {
     let type = args["type"] as? String ?? "Flutter"
     let response: Bool = NewRelic.recordCustomEvent(type)
     result(response)
    }
    
    static func recordException(args: [String: Any], result: FlutterResult){
        let stacktrace = args["stacktrace"] as? String ?? "String not found"
         NewRelic.recordHandledException(NSException.init(name: NSExceptionName.genericException, reason: stacktrace))
        result(true)
    }
    
    
    static func receiveBatteryLevel(result: FlutterResult) {
      let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
      if device.batteryState == UIDevice.BatteryState.unknown {
        result(FlutterError(code: "UNAVAILABLE",
                            message: "Battery level not available. Hello world",
                            details: nil))
      } else {
        result(Int(device.batteryLevel * 100))
      }
    }
    
}
