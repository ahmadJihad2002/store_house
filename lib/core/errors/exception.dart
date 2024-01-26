class ServerException implements Exception {
  String? error;
  ServerException({this.error});

}

class CacheException implements Exception {}
