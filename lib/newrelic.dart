import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class for interacting with native integrations through method channel
class NRIFlutter {
  // define method channel name
  static const platform = MethodChannel('nri.flutter');

  // set a string attribute
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

  // set a double attribute
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

  // set a bool attribute
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

  // increment a double attribute
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

  // send a custom event
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

  // send an exception event
  static Future<bool> recordException(String stacktrace) async {
    late bool response;
    try {
      final Map<String, dynamic> params = {'stacktrace': stacktrace};
      response = await platform.invokeMethod('recordException', params);
      return response;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
      return false;
    }
  }

  // crash the app
  static Future<bool> crashNow() async {
    late bool response;
    try {
      response = await platform.invokeMethod('crashNow');
      return response;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
      return false;
    }
  }
}
