package com.example.helloworld

import android.content.Intent
import android.os.Bundle
import android.view.View
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {
    private val CHANNEL = "flutter.native/helper"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Instantiate a FlutterEngine.
        setContentView(R.layout.activity_main)

        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
                call, result ->
            if (call.method == "onBackPressed") {
                onBackPressed()
            } else {
                result.notImplemented()
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        FlutterEngineCache
            .getInstance()
            .put("FlutterModule", flutterEngine)

        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
    fun onClickButtonAction(view: View) {
        val builder =
            withCachedEngine("FlutterModule")
        val intent: Intent = builder.build(activity.applicationContext)
        activity.startActivity(intent)
    }

}
