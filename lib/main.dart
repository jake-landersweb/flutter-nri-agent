import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:integration_test/newrelic.dart';
import 'package:integration_test/requests.dart';

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
      debugShowCheckedModeBanner: false,
      home: const BatteryChannel(),
    );
  }
}

class NewRelicMiddleWare extends StatefulWidget {
  const NewRelicMiddleWare({Key? key}) : super(key: key);

  @override
  State<NewRelicMiddleWare> createState() => _NewRelicMiddleWareState();
}

class _NewRelicMiddleWareState extends State<NewRelicMiddleWare> {
  @override
  void initState() {
    // run here

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BatteryChannel();
  }
}

class BatteryChannel extends StatefulWidget {
  const BatteryChannel({Key? key}) : super(key: key);

  @override
  State<BatteryChannel> createState() => _BatteryChannelState();
}

class _BatteryChannelState extends State<BatteryChannel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Image.asset("assets/newrelic.png"),
                  const SizedBox(height: 8),
                  Text(
                    "Team: 2nd Is The Best",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            _button("Send String", () async {
              var response = await NRIFlutter.setStringValue(
                  "flutterSetStringValue77", "value77");
              showSnackBar(context, response);
            }),
            const SizedBox(height: 8),
            _button("Send Double", () async {
              var response = await NRIFlutter.setDoubleValue(
                  "flutter-setDoubleValue", 2.0);
              showSnackBar(context, response);
            }),
            const SizedBox(height: 8),
            _button("Send Bool", () async {
              var response =
                  await NRIFlutter.setBoolValue("flutter-setBoolValue", true);
              showSnackBar(context, response);
            }),
            const SizedBox(height: 8),
            _button("Increment Value", () async {
              var response = await NRIFlutter.incrementValue(
                  "flutter-incrementValue",
                  value: 3);
              showSnackBar(context, response);
            }),
            const SizedBox(height: 8),
            _button("Send Custom Event", () async {
              var response = await NRIFlutter.setCustomValue("Flutter");
              showSnackBar(context, response);
            }),
            const SizedBox(height: 8),
            _button("Send Request", () async {
              var response = await sendRequest();
              showSnackBar(context, response);
            }),
            const SizedBox(height: 8),
            _button("Send Exception", () async {
              late bool response;
              try {
                int err = int.parse("hello world");
              } catch (error) {
                // send the nr event
                response = await NRIFlutter.setCustomValue(
                  "Flutter",
                  name: "Flutter",
                  attributes: {"exceptions": 1},
                );
              }
              showSnackBar(context, response);
            }),
            const SizedBox(height: 8),
            _button("Click Button", () async {
              late bool response;
              try {
                int err = int.parse("hello world");
              } catch (error) {
                // send the nr event
                response = await NRIFlutter.setCustomValue(
                  "Flutter",
                  name: "Flutter",
                  attributes: {"buttonClicks": 1},
                );
              }
              showSnackBar(context, response);
            }),
            const SizedBox(height: 8),
            _button("Crash App", () async {
              var response = await NRIFlutter.crashNow();
              showSnackBar(context, response);
            }),
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
        duration: const Duration(seconds: 1),
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
