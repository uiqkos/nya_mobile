
class NyaComment {
  final String id;
  final NyaAuthor author;
  final String text;
  final DateTime date;
  final int level;
  final List<String> path;
  final Map<String, NyaPrediction> predictions;

  const NyaComment({
    required this .id,
    required this .author,
    required this .text,
    required this .date,
    required this .level,
    required this .path,
    required this .predictions
  });

  static NyaComment fromJson(Map<String, dynamic> json, List<String> parentPath) {
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
        id: json['id'],
        path: List.from(parentPath)..add(json['id']),
        predictions: {
          // 'toxic': NyaPrediction(
          //   (json['toxic'] as Map).keys.first,
          //   (json['toxic'] as Map).values.first,
          //   (json['toxic'] as Map).values.elementAt(1)
          // ),
          // 'sentiment': NyaPrediction(
          //     (json['sentiment'] as Map).keys.first,
          //     json['sentiment'],
          //     (json['sentiment'] as Map).values.elementAt(1)
          // ),
          // 'sarcasm': NyaPrediction(
          //     (json['sarcasm'] as Map).keys.first,
          //     json['sarcasm'],
          //     (json['sarcasm'] as Map).values.elementAt(1)
          // ),
          'toxic': NyaPrediction('no toxic', 86, 1),
          'sentiment': NyaPrediction('netrual',99,0.5),
          'sarcasm': NyaPrediction('no sarcasm',62,1)
        }
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
  final int? percent;
  final double? grad;

  NyaPrediction(this.label, this.percent, this.grad);

  @override
  String toString() {
    return 'NyaPrediction{label: $label, percent: $percent, grad: $grad}';
  }
}
