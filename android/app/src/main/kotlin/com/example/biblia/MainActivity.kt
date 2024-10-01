package com.example.biblia

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import com.google.android.gms.ads.MobileAds

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.app/admob"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Inicializar AdMob
        MobileAds.initialize(this) {}

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "initialize" -> {
                    MobileAds.initialize(this) {}
                    result.success("AdMob initialized")
                }
                else -> result.notImplemented()
            }
        }
    }
}