class UpdateClientResponse{
  String? status;
  String? message;
  bool? data;

  UpdateClientResponse({this.status, this.message, this.data});

  UpdateClientResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }}