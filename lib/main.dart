import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String _batteryLevel = 'Unknown battery level.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _batteryLevel,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                var bat = await AppChannelMethods.getBatteryLevel();
                setState(() {
                  _batteryLevel = bat;
                });
              },
              child: const Text(
                "Get Battery",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                var bat = await AppChannelMethods.sendStringValue();
                log(bat.toString());
              },
              child: const Text(
                "Test String",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                var bat = await AppChannelMethods.sendIntValue();
                log(bat.toString());
              },
              child: const Text(
                "Test Int",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                var bat = await AppChannelMethods.sendDoubleValue();
                log(bat.toString());
              },
              child: const Text(
                "Test Double",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                var bat = await AppChannelMethods.sendBoolValue();
                log(bat.toString());
              },
              child: const Text(
                "Test Bool",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                var bat = await AppChannelMethods.sendIncrementValue();
                log(bat.toString());
              },
              child: const Text(
                "Test Increment Value",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                var bat = await AppChannelMethods.sendCustomValue();
                log(bat.toString());
              },
              child: const Text(
                "Test Custom Value",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppChannelMethods {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  static Future<String> getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    return batteryLevel;
  }

  static Future<bool> sendStringValue() async {
    late bool val;
    try {
      val = await platform.invokeMethod(
          'setStringValue', {"name": "stringName", "value": "stringValue"});
      return val;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  // setIntValue(name: string, value: int) -> bool
  static Future<bool> sendIntValue() async {
    late bool val;
    try {
      val = await platform
          .invokeMethod('setIntValue', {"name": "intName", "value": 100});
      return val;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  // setDoubleValue(name: string, value: double) -> bool
  static Future<bool> sendDoubleValue() async {
    late bool val;
    try {
      val = await platform.invokeMethod(
          'setDoubleValue', {"name": "doubleName", "value": 0.001});
      return val;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  // setBoolValue(name: string, value: bool) -> bool
  static Future<bool> sendBoolValue() async {
    late bool val;
    try {
      val = await platform
          .invokeMethod('setBoolValue', {"name": "boolName", "value": false});
      return val;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  // incrementValue(name: string, value: int) -> bool
  static Future<bool> sendIncrementValue() async {
    late bool val;
    try {
      val = await platform.invokeMethod(
          'setIncrementValue', {"name": "incrementValueName", "value": 5});
      return val;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  // setCustomValue(type: string, name: string, attributes: Map<String, dynamic>) -> bool
  static Future<bool> sendCustomValue() async {
    late bool val;
    try {
      val = await platform.invokeMethod('setCustomValue', {
        "type": "customType",
        "name": "customValueName",
        "attributes": {}
      });
      return val;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
