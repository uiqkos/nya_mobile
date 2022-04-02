class NyaPredictRequest {
  String text;
  String inputMethod;
  Map<String, String> models = {};
  String expandPath;
  int page;
  int perPage;

  NyaPredictRequest({
    required this .text,
    required this .inputMethod,
    this .expandPath = '',
    this .page = 0,
    this .perPage = 5,
  });

  NyaPredictRequest withExpand(String path) {
    return NyaPredictRequest(
      text: text,
      inputMethod: inputMethod,
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
