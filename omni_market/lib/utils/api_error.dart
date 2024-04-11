import 'dart:convert';

class ApiError {
  final String? error;
  final int? statusCode;
  final String? username;
  final int? errorCode;
  ApiError({
    this.error,
    this.statusCode,
    this.username,
    this.errorCode,
  });

  ApiError copyWith({
    String? error,
    int? statusCode,
    String? username,
    int? errorCode,
  }) {
    return ApiError(
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      username: username ?? this.username,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'statusCode': statusCode,
      'username': username,
      'errorCode': errorCode,
    };
  }

  factory ApiError.fromMap(Map<String, dynamic> map) {
    return ApiError(
      error: map['error'],
      statusCode: map['statusCode'],
      username: map['username'],
      errorCode: map['errorCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiError.fromJson(String source) =>
      ApiError.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApiError(error: $error, statusCode: $statusCode, username: $username, errorCode: $errorCode)';
  }

  @override
  // ignore: avoid_renaming_method_parameters
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ApiError &&
        o.error == error &&
        o.statusCode == statusCode &&
        o.username == username &&
        o.errorCode == errorCode;
  }

  @override
  int get hashCode {
    return error.hashCode ^
        statusCode.hashCode ^
        username.hashCode ^
        errorCode.hashCode;
  }
}
void sendBugReport({
  dynamic error,
  dynamic stackTree,
}) {
  // FirebaseCrashlytics.instance
  //     .recordError(error, StackTrace.fromString(stackTree.toString()));
  // Catcher.reportCheckedError(error, stackTree);
}