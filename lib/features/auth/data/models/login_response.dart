class LoginResponse {
  final String? status;
  final String? message;
  final String? data;

  const LoginResponse({this.status, this.message, this.data});

  @override
  String toString() {
    return 'LoginResponse(status: $status, message: $message, data: $data)';
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json['status'] as String?,
        message: json['message'] as String?,
        data: json['data'] as String?,
      );
}
