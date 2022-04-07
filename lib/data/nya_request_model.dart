import 'package:flutter/material.dart';
import 'package:nya_mobile/data/nya_predict_request.dart';

import 'nya_api.dart';
import 'nya_comment.dart';

class NyaPredictRequestModel extends ChangeNotifier {
  static late final NyaApi api;
  NyaPredictRequest? request;
  Map<String, int> pageByPath = {};
  NyaComment? rootComment;

  bool get isEmpty {
    return request == null;
  }

  void clear() {
    request = null;
    rootComment = null;
    pageByPath.clear();
  }

  static void init(String url) async {
    api = NyaApi(url);
  }

  void nextPage(String path) {
    if (!pageByPath.containsKey(path)) {
      pageByPath[path] = 0;
    }
    pageByPath[path] = pageByPath[path]! + 1;

    request?.expandPath = path;
    request?.page = pageByPath[path]!;

    notifyListeners();
  }

  Future<List<NyaModel>> getModels() async {
    return await api.models();
  }

  Future<NyaComment?> getComments() async {
    if (request == null) return null;

    var response = await api.predictRequest(request!);

    var path = List.from(response.path);
    var currentComment = rootComment;

    if (path.isEmpty) {
      rootComment = response.items.first;
      return rootComment;
    }

    while (path.isNotEmpty) {
      var parentId = path.removeAt(0);

      for (var comment in currentComment!.comments) {
        if (comment.id == parentId) {
          currentComment = comment;
          break;
        }
      }
    }

    currentComment!.comments.addAll(response.items);

    return rootComment;
  }
}
