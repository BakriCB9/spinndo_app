class ImageProfileResponse {
  String? status;
  String? message;
  String? data;

  ImageProfileResponse({this.status, this.message, this.data});

  ImageProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }
}