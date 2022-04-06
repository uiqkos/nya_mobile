import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _sharingChannel = MethodChannel('ru.nya.nya_mobile/sharing');

class NyaSharedLinkProvider extends ChangeNotifier {
  String? _sharedLink;

  NyaSharedLinkProvider() {
    _sharingChannel.setMethodCallHandler(_methodCallHandler);
  }

  Future<void> _methodCallHandler(MethodCall call) async {
    if (call.method == "onLinkChanged") {
      _sharedLink = call.arguments["link"];
      notifyListeners();
    }
  }

  String? get sharedLink => _sharedLink;
}