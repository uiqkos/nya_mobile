package ru.nya.nya_mobile

import android.content.Intent
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private lateinit var sharingChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        sharingChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "ru.nya.nya_mobile/sharing",
        )

//        flutterChannel.setMethodCallHandler { call, result ->
//            if (call.method == "getSharedLink") {
//                result.success(sharedLink)
//            } else {
//                result.notImplemented()
//            }
//        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)

        if (intent.action == Intent.ACTION_SEND) {
            val sharedLink = intent.getCharSequenceExtra(Intent.EXTRA_TEXT).toString()
            sharingChannel.invokeMethod("onLinkChanged", mapOf(
                "link" to sharedLink,
            ))
        }
    }


}
