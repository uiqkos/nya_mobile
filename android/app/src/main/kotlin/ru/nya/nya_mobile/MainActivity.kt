package ru.nya.nya_mobile

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private var sharedLink: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        if (intent.action == Intent.ACTION_SEND) {
            sharedLink = intent.getCharSequenceExtra(Intent.EXTRA_TEXT).toString()
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "ru.nya.nya_mobile",
        ).setMethodCallHandler { call, result ->
            if (call.method == "getSharedLink") {
                result.success(sharedLink)
            } else {
                result.notImplemented()
            }
        }
    }
}
