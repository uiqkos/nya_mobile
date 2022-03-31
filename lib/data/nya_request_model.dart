import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nya_mobile/data/nya_predict_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'nya_api.dart';
import 'nya_predict_response.dart';

class NyaPredictRequestModel extends ChangeNotifier {
  static late final NyaApi api;
  NyaPredictRequest? _request;

  set request(NyaPredictRequest request) {
    _request = request;
    // notifyListeners();
  }

  bool get isEmpty {
    return _request == null;
  }

  void clear() {
    _request = null;
  }

  void updateExpandPath(String path) {
    _request?.expandPath = path;
    notifyListeners();
  }

  static void init(String url) async {
    api = NyaApi(url);
  }

  Future<NyaPredictResponse> get() async {
    var response = await api.predictRequest(_request!);
    return response;
  }
}
