class HttpException {
  HttpException({
    required this.statusCode,
    required this.timestamp,
    required this.path,
    required this.message,
  });

  int statusCode;
  DateTime timestamp;
  String path;
  String message;

  factory HttpException.fromJson(Map<String, dynamic> json) => HttpException(
        statusCode: json['statusCode'] as int,
        timestamp: DateTime.parse(json['timestamp'] as String),
        path: json['path'] as String,
        message: json['message'] as String,
      );

  @override
  String toString() {
    return 'HttpException{statusCode: $statusCode, timestamp: $timestamp, path: $path, message: $message}';
  }
}
