import 'dart:convert';

import 'package:http/http.dart' as http;

import 'nya_comment.dart';
import 'nya_predict_request.dart';
import 'nya_predict_response.dart';

class NyaApi {
  final Uri base;

  NyaApi(String uri) : base = Uri.parse(uri);

  Future<dynamic> _getJson(String postfix,
      {Map<String, dynamic> params = const {}}) async {
    var response = (await http.get(Uri(
          scheme: base.scheme,
          host: base.host,
          port: base.port,
          path: base.path + postfix,
          queryParameters: params
    ), headers: {"Content-type": "application/json"}));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }
  Future<NyaPredictResponse> predictRequest(NyaPredictRequest request) {
    return predict(
      request.text, request.inputMethod,
      models: request.models, expand: request.expandPath,
      page: request.page, perPage: request.perPage
    );
  }

  Future<NyaPredictResponse> predict(
      String text, String inputMethod,
      {Map<String, String> models = const {}, String? expand, int? page, int? perPage}) async {
    Map<String, dynamic> params = {
      'text': text,
      'input': inputMethod,
    };

    params.addAll(models);

    if (page != null) params['page'] = page.toString();
    if (perPage != null) params['per_page'] = perPage.toString();
    if (expand != null) params['expand'] = expand;

    var json = await _getJson('predict', params: params);
    var path = (json['path'] as String)
        .split('/')
        ..removeWhere((s) => s == '');

    // print(json);

    var comments = (json['items'] as List)
        .map((e) => NyaComment.fromJson(e, path, json['grads']))
        .toList();

    return NyaPredictResponse(
      path: path,
      perPage: json['per_page'],
      page: json['page'],
      count: json['count'],
      items: comments
    );
  }

  Future<List<NyaModel>> models() async {
    return (await _getJson('models') as List)
        .map((e) => NyaModel.fromJson(e)).toList();
  }

  Future<List<NyaReport>> reports() async {
    return (await _getJson('reports') as List)
        .map((e) => NyaReport.fromJson(e)).toList();
  }

  Future<NyaReport> reportById(String id) async {
    return NyaReport.fromJson(await _getJson('reports/' + id));
  }
}

class NyaModel {
  final String displayName;
  final String name;
  final String target;

  NyaModel({required this.name, required this.displayName, required this.target});

  static NyaModel fromJson(Map<String, dynamic> json) {
    return NyaModel(
        name: json['local_name'],
        displayName: json['name'],
        target: json['target']
    );
  }

  @override
  String toString() {
    return 'NyaModel{displayName: $displayName, name: $name, target: $target}';
  }
}


class NyaTag {
  final String name;
  final int grad;

  NyaTag({
    required this .name,
    required this .grad
  });

  static NyaTag fromJson(Map<String, dynamic> json) {
    return NyaTag(
      name: json['name'],
      grad: json['grad'],
    );
  }
}


class NyaReport {
  final String name;
  final String title;
  final String text;
  final List<NyaTag> tags;

  NyaReport({
    required this .name,
    required this .title,
    required this .text,
    required this .tags,
  });

  static NyaReport fromJson(Map<String, dynamic> json) {
    return NyaReport(
      text: json['text'],
      name: json['name'],
      title: json['title'],
      tags: (json['tags'] as List)
          .map((e) => NyaTag.fromJson(e)).toList(),
    );
  }
}
