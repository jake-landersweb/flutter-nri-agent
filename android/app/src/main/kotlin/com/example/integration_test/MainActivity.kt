package com.example.integration_test

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

import android.os.Bundle

import com.newrelic.agent.android.NewRelic;

class MainActivity: FlutterActivity() {
    private val CHANNEL = "nri.flutter"

    override fun onCreate(savedInstanceState: Bundle?) {
      NewRelic.withApplicationToken(" YOUR APP TOKEN ").start(this.applicationContext)
      super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
        
      // This method is invoked on the main thread.
        call, result ->
        // Send String
        if (call.method == "setStringValue"){
          val name: String = call.argument("name")!!
          val value: String = call.argument("value")!!
          val response: Boolean = NewRelic.setAttribute(name, value)
          result.success(response)

        // Send Int
        } else if (call.method == "setIntValue"){
          val name: String = call.argument("name")!!
          val value: Int = call.argument("value")!!
          val response: Boolean = NewRelic.setAttribute(name, value.toString())
          result.success(response)

        // Send Double
        } else if (call.method == "setDoubleValue"){
          val name: String = call.argument("name")!!
          val value: Double = call.argument("value")!!
          val response: Boolean = NewRelic.setAttribute(name, value)
          result.success(response)

        // Send Boolean
        } else if (call.method == "setBoolValue"){
          val name: String = call.argument("name")!!
          val value: Boolean = call.argument("value")!!
          val response: Boolean = NewRelic.setAttribute(name, value)
          result.success(response)

        // Increment Double
        } else if (call.method == "incrementValue"){
          val name: String = call.argument("name")!!
          var value: Double = call.argument("value")!!
          val response: Boolean = NewRelic.incrementAttribute(name, value)
          result.success(response)

        // Send Custom object
        } else if (call.method == "setCustomValue"){
          val type: String = call.argument("type")!!
          val name: String = call.argument("name")!!
          val attributes: Map<String, Any>? = call.argument("attributes")!!
          val response = NewRelic.recordCustomEvent(type, name, attributes)
          result.success(response)
        
        // Send an exception which was caught
        } else if (call.method == "triggerException"){
          val framework: String = call.argument("value")!!

          try{
            if (framework.equals("flutter")){
              throw Exception("React is the incorrect framework!")
            }
          } catch (e: Exception){
            NewRelic.recordHandledException(e)
            result.success(true)
          }
        
        // Crash app
        } else if (call.method == "crashNow") {
          NewRelic.crashNow()
        
        // Query not matched
        } else{
          result.error("UNAVAILABLE","Data .", null)
        }
      }
    }
}
