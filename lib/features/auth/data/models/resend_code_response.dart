class ResendCodeResponse {
	String? status;
	String? message;
	bool? data;

	ResendCodeResponse({this.status, this.message, this.data});

	factory ResendCodeResponse.fromJson(Map<String, dynamic> json) {
		return ResendCodeResponse(
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
