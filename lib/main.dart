import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:integration_test/newrelic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BatteryChannel(),
    );
  }
}

class BatteryChannel extends StatefulWidget {
  const BatteryChannel({Key? key}) : super(key: key);

  @override
  State<BatteryChannel> createState() => _BatteryChannelState();
}

class _BatteryChannelState extends State<BatteryChannel> {
  String _battery = "N/A";

  String _customValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: const InputDecoration(hintText: "Custom value"),
                onChanged: (value) {
                  setState(() {
                    _customValue = value;
                  });
                },
              ),
            ),
            CupertinoButton(
                child: Text("setStringValue"),
                onPressed: () async {
                  var response = await NRIFlutter.setStringValue(
                      "flutterSetStringValue", _customValue);
                  showSnackBar(context, response);
                }),
            const SizedBox(height: 8),
            _button("setStringValue", () async {
              var response = await NRIFlutter.setStringValue(
                  "flutterSetStringValue77", "value77");
              showSnackBar(context, response);
            }),
            const SizedBox(height: 8),
            _button("setIntValue", () async {
              var response =
                  await NRIFlutter.setIntValue("flutter-setIntValue", 1);
              showSnackBar(context, response);
            }),
            const SizedBox(height: 8),
            _button("setDoubleValue", () async {
              var response = await NRIFlutter.setDoubleValue(
                  "flutter-setDoubleValue", 2.0);
              showSnackBar(context, response);
            }),
            const SizedBox(height: 8),
            _button("setBoolValue", () async {
              var response =
                  await NRIFlutter.setBoolValue("flutter-setBoolValue", true);
              showSnackBar(context, response);
            }),
            const SizedBox(height: 8),
            _button("incrementValue", () async {
              var response = await NRIFlutter.incrementValue(
                  "flutter-incrementValue",
                  value: 3);
              showSnackBar(context, response);
            }),
            const SizedBox(height: 8),
            _button("setCustomValue", () async {
              var response = await NRIFlutter.setCustomValue("Flutter");
              showSnackBar(context, response);
            }),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Image.asset("assets/newrelic.png"),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, bool response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response ? "Successfully sent NRI event" : "Failed to send NRI event",
        ),
      ),
    );
  }

  Widget _button(String name, VoidCallback onTap) {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromRGBO(29, 37, 44, 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: const Color.fromRGBO(4, 171, 105, 1), width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            name,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ),
    );
  }

  static const platform = MethodChannel('samples.flutter.dev/battery');
  void getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _battery = result.toString();
      });
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
      setState(() {
        _battery = "N/A";
      });
    }
  }

  static Future<bool> setIntValue() async {
    late bool val;
    try {
      val = await platform.invokeMethod('setIntValue', {"name": "flutter-setIntName", "value": "flutter-setIntValue"});
      return val;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> setDoubleValue() async {
    late bool val;
    try {
      val = await platform.invokeMethod('setDoubleValue', {"name": "flutter-setDoubleName", "value": "flutter-setDoubleValue"});
      return val;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> setBoolValue() async {
    late bool val;
    try {
      val = await platform.invokeMethod('setBoolValue', {"name": "flutter-setBoolName", "value": "flutter-setBoolValue"});
      return val;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> incrementValue() async {
    late bool val;
    try {
      val = await platform.invokeMethod('incrementValue', {"name": "flutter-incrementName", "value": "flutter-incrementValue"});
      return val;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

}

// class BatteryChannelMethod {
//   static const platform = MethodChannel('samples.flutter.dev/battery');

  // static Future<String> getBatteryLevel() async {
  //   String batteryLevel;
  //   try {
  //     final int result = await platform.invokeMethod('getBatteryLevel');
  //     batteryLevel = 'Battery level at $result % .';
  //   } on PlatformException catch (e) {
  //     batteryLevel = "Failed to get battery level: '${e.message}'.";
  //   }

  //   return batteryLevel;
  // }

//   static Future<bool> sendNREvent() async {
//     late bool val;
//     try {
//       val = await platform.invokeMethod('testNRI');
//       return val;
//     } on PlatformException catch (e) {
//       print(e);
//       return false;
//     }
//   }
// }
