class NyaPredictRequest {
  final String text;
  final String inputMethod;
  final Map<String, String> models;
  String? expandPath;
  final int? page;
  final int? perPage;

  NyaPredictRequest({
    required this .text,
    required this .inputMethod,
    this .models = const {},
    this .expandPath,
    this .page,
    this .perPage,
  });

  NyaPredictRequest withExpand(String path) {
    return NyaPredictRequest(
      text: text,
      inputMethod: inputMethod,
      models: models,
      expandPath: path,
      page: page,
      perPage: perPage
    );
  }

  @override
  String toString() {
    return 'NyaPredictRequest{text: $text, inputMethod: $inputMethod, models: $models, expandPath: $expandPath, page: $page, perPage: $perPage}';
  }
}
