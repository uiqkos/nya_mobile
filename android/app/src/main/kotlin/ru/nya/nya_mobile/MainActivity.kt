package ru.nya.nya_mobile

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private lateinit var sharingChannel: MethodChannel
    private var sharedLink: String? = null;

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        sharingChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "ru.nya.nya_mobile/sharing",
        )

        sharingChannel.setMethodCallHandler { call, result ->
            if (call.method == "getSharedLink") {
                result.success(sharedLink)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        handleSendIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)

        handleSendIntent(intent)

        sharingChannel.invokeMethod("onLinkChanged", mapOf(
            "link" to sharedLink,
        ))
    }

    private fun handleSendIntent(intent: Intent?) {
        if (intent?.action == Intent.ACTION_SEND) {
            sharedLink = intent.getCharSequenceExtra(Intent.EXTRA_TEXT).toString()
        }
    }
}
