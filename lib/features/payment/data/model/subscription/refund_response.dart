class RefundResponse {
  final String status;
  final String message;
  final bool data;

  RefundResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RefundResponse.fromJson(Map<String, dynamic> json) {
    return RefundResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] ?? false,
    );
  }
}
