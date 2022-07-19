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
                var bat = await BatteryChannelMethod.getBatteryLevel();
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
                var bat = await BatteryChannelMethod.sendNREvent();
                log(bat.toString());
              },
              child: const Text(
                "Test Event",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BatteryChannelMethod {
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

  static Future<bool> sendNREvent() async {
    late bool val;
    try {
      val = await platform.invokeMethod('testNRI');
      return val;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
