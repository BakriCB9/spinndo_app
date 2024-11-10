class RegisterResponse {
  final String? status;
  final String? message;
  final String? data;

  const RegisterResponse({this.status, this.message, this.data});

  @override
  String toString() {
    return 'RegisterResponse(status: $status, message: $message, data: $data)';
  }

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] as String?,
    );
  }
}
