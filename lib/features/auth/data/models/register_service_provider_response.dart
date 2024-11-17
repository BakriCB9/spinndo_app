class RegisterServiceProviderResponse {
  final String? status;
  final dynamic message;
  final String? data;

  const RegisterServiceProviderResponse({this.status, this.message, this.data});

  @override
  String toString() {
    return 'RegisterResponse(status: $status, message: $message, data: $data)';
  }

  factory RegisterServiceProviderResponse.fromJson(Map<String, dynamic> json) {
    return RegisterServiceProviderResponse(
      status: json['status'] as String?,
      message: json['message'] as dynamic,
      data: json['data'] as String?,
    );
  }
}
