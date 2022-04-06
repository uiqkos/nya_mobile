
class NyaComment {
  final String id;
  final NyaAuthor author;
  final String text;
  final DateTime date;
  final int level;
  final int commentCount;
  final List<String> path;
  final List<NyaPrediction> predictions;
  List<NyaComment> comments;

  NyaComment({
    required this .id,
    required this .author,
    required this .text,
    required this .date,
    required this .level,
    required this .commentCount,
    required this .path,
    required this .predictions,
    List<NyaComment>? comments
  }): comments = comments ?? [];

  static NyaComment fromJson(
      Map<String, dynamic> json,
      List<String> parentPath,
      Map<String, dynamic> grads
  ) {
    // print(grads);
    var c = NyaComment(
        author: NyaAuthor(
            name: json['author']['name'].toString(),
            photoUrl: json['author']['photo'] is int
                ? null
                : json['author']['photo'],
        ),
        text: json['text'],
        date: DateTime.parse(json['date']),
        level: json['level'],
        commentCount: json['comments'],
        id: json['id'],
        path: List.from(parentPath)..add(json['id']),
        predictions: (json['predictions'] as Map<String, dynamic>)
          .entries
          .map((entry) =>
            NyaPrediction.fromJson(entry.value, grads[entry.key]))
          .toList()
    );

    // print(c);
    return c;

  }

  @override
  String toString() {
    return 'NyaComment{id: $id, author: $author, text: $text, date: $date, level: $level, path: $path, predictions: $predictions}';
  }
}

class NyaAuthor {
  final String name;
  final String? photoUrl;

  NyaAuthor({required this.name, required this.photoUrl});

  @override
  String toString() {
    return 'Author{name: $name, photoUrl: $photoUrl}';
  }
}

class NyaPrediction {
  final String label;
  final int percent;
  final int grad;

  NyaPrediction(this.label, this.percent, this.grad);

  static NyaPrediction fromJson(
      Map<String, dynamic> json,
      Map<String, dynamic> grads
  ) {
    var best = json.entries.fold<MapEntry>(
        const MapEntry('unknown', 0.0),
        (previous, element) =>
          (element.value > previous.value)
              ? element
              : previous
    );

    return NyaPrediction(best.key, (best.value * 100.0).round(), grads[best.key] as int);
  }

  @override
  String toString() {
    return 'NyaPrediction{label: $label, percent: $percent, grad: $grad}';
  }
}
