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
        NewRelic.start(withApplicationToken: " YOUR APP TOKEN ")
        NewRelic.enableCrashReporting(true)
        NewRelic.removeAllAttributes()
//      NewRelic.setAttribute("PLEASEWORKNAME", value: "PLEASEWORKVALUE")

        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let batteryChannel = FlutterMethodChannel(name: "nri.flutter", binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            guard let args = call.arguments as? [String : Any] else {return}
                     
            /* dependig on case, program will call specfic method*/
            switch call.method {
            case "testNRI": NewRelicIntegration.sendNewRelicEvent(result: result, name: "test-event")
            case "setStringValue": NewRelicIntegration.setStringValue(args: args, result: result)
            case "setDoubleValue": NewRelicIntegration.setDoubleValue(args: args, result: result)
            case "setBoolValue": NewRelicIntegration.setBoolValue(args: args, result: result)
            case "incrementValue": NewRelicIntegration.incrementValue(args: args, result: result)
            case "setCustomValue": NewRelicIntegration.setCustomValue(args: args, result: result)
            case "recordException": NewRelicIntegration.recordException(args: args, result: result)
            case "crashNow": NewRelicIntegration.crashNow(result: result)
            default: result(FlutterMethodNotImplemented)
            }
        })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

/* all of the native methods for ios are defined below*/
class NewRelicIntegration {
    static func sendNewRelicEvent(result: FlutterResult, name: String) {
        let val: Bool = NewRelic.recordCustomEvent("flutterTestEvent2", name: "ios")
        NewRelic.setAttribute("flutterTestEvent3", value: 3)
        result(val)
    }
    
    // returns true or false based on response
    static func setStringValue(args: [String:Any], result: FlutterResult){
        let name = args["name"] as? String ?? "String not found"
        let value = args["value"] as? String ?? "Value not found"
        let response: Bool = NewRelic.setAttribute(name, value: value)
        result(response)
    }
    
    // set integer method
    static func setIntValue(args: [String:Any], result: FlutterResult){
     let name = args["name"] as? String ?? "String not found"
     let value: Int = args["value"] as! Int
     let response: Bool = NewRelic.setAttribute(name, value: value)
     result(response)
    }
    
    //set double method
    static func setDoubleValue(args: [String:Any], result: FlutterResult){
     let name = args["name"] as? String ?? "String not found"
     let value: Double = args["value"] as! Double
     let response: Bool = NewRelic.setAttribute(name, value: value)
     result(response)
    }
    
    // set bool method
    static func setBoolValue(args: [String:Any], result: FlutterResult){
     let name = args["name"] as? String ?? "String not found"
     let value: Bool = args["value"] as! Bool
     let response: Bool = NewRelic.setAttribute(name, value: value)
     result(response)
    }
    
    // incrementValue method
    static func incrementValue(args: [String:Any], result: FlutterResult){
     let name = args["name"] as? String ?? "String not found"
     let value = args["value"] as? String ?? "Value not found"
     let response: Bool = NewRelic.setAttribute(name, value: value)
     result(response)
    }
    
    // record an exception
    static func recordException(args: [String: Any], result: FlutterResult){
     let stacktrace = args["stacktrace"] as? String ?? "String not found"
     NewRelic.recordHandledException(NSException.init(name: NSExceptionName.genericException, reason: stacktrace))
     result(true)
    }
    
    // set a custom value
    static func setCustomValue(args: [String : Any], result: FlutterResult) {
        let type = args["type"] as? String ?? "Flutter"
        let attributes = args["attributes"] as! [String : Any]
        let response: Bool = NewRelic.recordCustomEvent(type, attributes: attributes)
        result(response)
    }
    
    // crash the app
    static func crashNow(result: FlutterResult) {
        NewRelic.crashNow()
        result(true)
    }
}
