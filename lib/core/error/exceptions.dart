class ServerException implements Exception {}

class DatabaseException implements Exception {
  final String error;

  DatabaseException({required this.error});
}

class FormatException implements Exception {}

class InternalException implements Exception {
  final String error;

  InternalException({required this.error});
}
