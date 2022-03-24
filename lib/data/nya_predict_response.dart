
import 'nya_comment.dart';

class NyaPredictResponse {
  final List<String> path;
  final int perPage;
  final int page;
  final int count;
  final List<NyaComment> items;

  NyaPredictResponse({
    required this .path,
    required this .perPage,
    required this .page,
    required this .count,
    required this .items
  });

  @override
  String toString() {
    return 'NyaPredictResponse{path: $path, perPage: $perPage, page: $page, count: $count, items: $items}';
  }
}