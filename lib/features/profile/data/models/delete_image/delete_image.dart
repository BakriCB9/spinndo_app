class DeleteImageResponse {
  String? status;
  String? message;
  String? data;

  DeleteImageResponse({this.status, this.message, this.data});

  DeleteImageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }
}
