package com.example.integration_test

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

import com.newrelic.agent.android.NewRelic;

class MainActivity: FlutterActivity() {
    private val CHANNEL = "nri.flutter"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    NewRelic.withApplicationToken("AAf4a2c3bb308be98bbbf9008dd84b65d9cb3b4d07-NRMA").start(this.applicationContext)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
        // This method is invoked on the main thread.
        call, result ->
        if (call.method == "getBatteryLevel") {
          print("CALLED METHOD CHANNEL")
          val batteryLevel = getBatteryLevel()

          if (batteryLevel != -1) {
            result.success(batteryLevel)
          } else {
            result.error("UNAVAILABLE", "Battery level not available.", null)
          }
        } 
        //setStringValue(name: string, value: string) -> bool
        else if (call.method == "setStringValue"){
          val name: String = call.argument("name")!!
          val value: String = call.argument("value")!!
          val response: Boolean = NewRelic.setAttribute(name, value)
          result.success(response)

        } else if (call.method == "setIntValue"){
          val name: String = call.argument("name")!!
          val value: Int = call.argument("value")!!
          val response: Boolean = NewRelic.setAttribute(name, value.toString())
          result.success(response)

        } else if (call.method == "setDoubleValue"){
          val name: String = call.argument("name")!!
          val value: Double = call.argument("value")!!
          val response: Boolean = NewRelic.setAttribute(name, value)
          result.success(response)

        } else if (call.method == "setBoolValue"){
          val name: String = call.argument("name")!!
          val value: Boolean = call.argument("value")!!
          val response: Boolean = NewRelic.setAttribute(name, value)
          result.success(response)

        } else if (call.method == "setIncrementValue"){
          val name: String = call.argument("name")!!
          var value: Int = call.argument("value")!!
          value = value + 1 
          val response: Boolean = NewRelic.setAttribute(name, value.toString())
          result.success(response)

        } else if (call.method == "setCustomValue"){
          val type: String = call.argument("type")!!
          val name: String = call.argument("name")!!
          val attributes: Map<String, Any>? = call.argument("attributes")!!
          val response = NewRelic.recordCustomEvent(type, name, attributes)
          result.success(response)

        } else{
          result.error("UNAVAILABLE","Data .", null)
        }
      }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
          val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
          batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
          val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
          batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
    
        return batteryLevel
    }
}
