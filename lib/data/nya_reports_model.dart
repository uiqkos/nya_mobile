import 'package:flutter/material.dart';
import 'package:nya_mobile/data/nya_predict_request.dart';

import 'nya_api.dart';
import 'nya_comment.dart';

class NyaReportsModel extends ChangeNotifier {
  static late final NyaApi api;
  late List<NyaReport> reports;
  NyaReport? report;

  static void init(String url) async {
    api = NyaApi(url);
  }

  void fetchReports() async {
    reports = await api.reports();
    notifyListeners();
  }

  void selectReportById(String id) async {
    report = await api.reportById(id);
    notifyListeners();
  }
}
