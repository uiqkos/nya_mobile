import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NyaSharedLinkProvider extends ChangeNotifier {
  final _sharingChannel = const MethodChannel('ru.nya.nya_mobile/sharing');
  String? _sharedLink;

  NyaSharedLinkProvider() {
    _sharingChannel.setMethodCallHandler((call) async {
      if (call.method == "onLinkChanged") {
        _sharedLink = call.arguments["link"];
        notifyListeners();
      }
    });
  }

  Future<String?> getSharedLink() async {
    return _sharedLink ?? await _sharingChannel.invokeMethod("getSharedLink");
  }
}