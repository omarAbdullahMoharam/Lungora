
class Result {
  final String message;

  Result({required this.message});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}

// Custom exception classes
class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}
