import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NRIFlutter {
  static const platform = MethodChannel('nri.flutter');

  static Future<bool> setStringValue(String name, String value) async {
    late bool response;
    try {
      final Map<String, dynamic> params = {'name': name, "value": value};
      response = await platform.invokeMethod('setStringValue', params);
      return response;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
      return false;
    }
  }

  static Future<bool> setDoubleValue(String name, double value) async {
    late bool response;
    try {
      final Map<String, dynamic> params = {'name': name, "value": value};
      response = await platform.invokeMethod('setDoubleValue', params);
      return response;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
      return false;
    }
  }

  static Future<bool> setBoolValue(String name, bool value) async {
    late bool response;
    try {
      final Map<String, dynamic> params = {'name': name, "value": value};
      response = await platform.invokeMethod('setBoolValue', params);
      return response;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
      return false;
    }
  }

  static Future<bool> incrementValue(String name, {double value = 1.0}) async {
    late bool response;
    try {
      final Map<String, dynamic> params = {'name': name, "value": value};
      response = await platform.invokeMethod('incrementValue', params);
      return response;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
      return false;
    }
  }

  static Future<bool> setCustomValue(String type,
      {String name = "", Map<String, dynamic>? attributes}) async {
    late bool response;
    try {
      final Map<String, dynamic> params = {
        'type': type,
        'name': name,
        "attributes": attributes ?? {}
      };
      response = await platform.invokeMethod('setCustomValue', params);
      return response;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
      return false;
    }
  }
}
