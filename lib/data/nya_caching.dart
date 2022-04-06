
class NyaCacher {
  final Map<String, dynamic> _cacheByKey = {};

  dynamic getCache(String key, Function supplier) {
    if (!_cacheByKey.containsKey(key)) {
      _cacheByKey[key] = supplier.call();
    }
    return _cacheByKey[key];
  }

  void invalidateAll() {
    _cacheByKey.clear();
  }

  void invalidateCache(String key) {
    _cacheByKey.remove(key);
  }
}

class NyaCacherProvider {
  static final Map<String, NyaCacher> _cachers = {};

  static NyaCacher provide(String key) {
    _cachers[key] ??= NyaCacher();
    return _cachers[key]!;
  }

  static void clear() {
    _cachers.clear();
  }
}
