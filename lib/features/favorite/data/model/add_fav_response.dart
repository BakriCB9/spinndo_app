class AddFavResponse {
	String? status;
	String? message;
	String? data;

	AddFavResponse({this.status, this.message, this.data});

	factory AddFavResponse.fromJson(Map<String, dynamic> json) {
		return AddFavResponse(
			status: json['status'] as String?,
			message: json['message'] as String?,
			data: json['data'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'status': status,
				'message': message,
				'data': data,
			};
}
