class ResetPasswordResponse {
	String? status;
	String? message;
	bool? data;

	ResetPasswordResponse({this.status, this.message, this.data});

	factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
		return ResetPasswordResponse(
			status: json['status'] as String?,
			message: json['message'] as String?,
			data: json['data'] as bool?,
		);
	}



	Map<String, dynamic> toJson() => {
				'status': status,
				'message': message,
				'data': data,
			};
}
