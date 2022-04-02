import 'package:flutter/material.dart';
import 'package:nya_mobile/data/nya_predict_request.dart';

import 'nya_api.dart';
import 'nya_comment.dart';

class NyaPredictRequestModel extends ChangeNotifier {
  static late final NyaApi api;
  NyaPredictRequest? request;
  Map<String, int> pageByPath = {};
  List<NyaComment> comments = [];

  bool get isEmpty {
    return request == null;
  }

  void clear() {
    request = null;
    comments = [];
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

  Future<List<NyaComment>?> getComments() async {
    if (request == null) return null;

    var response = await api.predictRequest(request!);

    var insertIndex = 0;
    var path = List.from(response.path);

    while (path.isNotEmpty) {
      var parentId = path.removeAt(0);

      while (
        insertIndex < comments.length &&
        comments.elementAt(insertIndex).id != parentId
      ) {
        insertIndex += 1;
      }
    }

    if (insertIndex < comments.length) {
      var level = comments.elementAt(insertIndex).level + 1;

      insertIndex = comments.indexWhere(
          (element) => element.level < level,
          insertIndex + 1
      );
      if (insertIndex == -1) {
        insertIndex = comments.length;
      }
    }

    comments.insertAll(insertIndex, response.items);

    return comments;
  }
}
