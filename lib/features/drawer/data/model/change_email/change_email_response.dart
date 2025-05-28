class ChangeEmailResponse {
  String? status;
  String? message;
  dynamic data;

  ChangeEmailResponse({this.status, this.message, this.data});

  ChangeEmailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }
}