class ChangePasswordResponse {
  String? status;
  String? message;
  dynamic data;

  ChangePasswordResponse({this.status, this.message, this.data});

  ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }
}
