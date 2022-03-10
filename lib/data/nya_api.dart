import 'dart:convert';

import 'package:http/http.dart' as http;

class NyaApi {
  final Uri base;

  NyaApi(String uri) : base = Uri.parse(uri);

  Future<dynamic> _getJson(String postfix,
      {Map<String, dynamic> params = const {}}) async {
    var response = (await http.get(Uri(
          scheme: base.scheme,
          host: base.host,
          port: base.port,
          path: base.path + '/' + postfix,
          queryParameters: params
    ), headers: {"Content-type": "application/json"}));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  Future<List<NyaComment>> predict(
      String text, String inputMethod,
      {Map<String, String> models = const {}, int? page, int? perPage}) async {
    Map<String, dynamic> params = {
      'text': text,
      'input': inputMethod,
    };

    params.addAll(models);

    if (page != null) params['page'] = page;
    if (perPage != null) params['perPage'] = perPage;

    var json = await _getJson('predict', params: params);
    return (json['items'] as List).map((e) => NyaComment.fromJson(e)).toList();
  }

  Future<List<NyaModel>> models() async {
    return (await _getJson('models') as List).map((e) => NyaModel.fromJson(e)).toList();
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

class NyaComment {
  final Author author;
  final String text;
  final DateTime date;
  final int level;
  final Map<String, Map<String, double>?> predictions;

  NyaComment({
    required this.author,
    required this.text,
    required this.date,
    required this.level,
    required this.predictions
  });

  static NyaComment fromJson(Map<String, dynamic> json) {
    return NyaComment(
        author: Author(
            name: json['author']['name'],
            photoUrl: json['author']['photo']
        ),
        text: json['text'],
        date: DateTime.parse(json['date']),
        level: json['level'],
        predictions: {
          'toxic': json['toxic'],
          'sentiment': json['sentiment'],
          'sarcasm': json['sarcasm'],
        }
    );
  }

  @override
  String toString() {
    return 'NyaComment{author: $author, text: $text, date: $date, level: $level, predictions: $predictions}';
  }
}

class Author {
  final String name;
  final String photoUrl;

  Author({required this.name, required this.photoUrl});

  @override
  String toString() {
    return 'Author{name: $name, photoUrl: $photoUrl}';
  }
}