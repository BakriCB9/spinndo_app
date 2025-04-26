class UnSubscribeResponse {
  final String status;
  final String message;
  final bool data;

  UnSubscribeResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UnSubscribeResponse.fromJson(Map<String, dynamic> json) {
    return UnSubscribeResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] ?? false,
    );
  }
}
