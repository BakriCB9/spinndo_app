class Data {
  final dynamic id;
  final String? role;
  final dynamic isApproved;
  final String? phone;
  final String? token;
  final String? firstName;
  final String? lastName;
  final dynamic imagePath;
  final dynamic accountStatus;
  final String? email;

  factory Data.fromJson(Map<String, dynamic> json) {
    final ans = Data(
      id: json['id'] as dynamic,
      role: json['role'] as String,
      isApproved: json['isApproved'] as dynamic,
      token: json['token'] as String,
      firstName: json['first_name'] as String ?? "",
      lastName: json['last_name'] as String ?? "",
      imagePath: json['image_path'] as dynamic,
      accountStatus: json['account_status'] as dynamic,
      email:json['email'] as String?,
      phone:json['phone'] as String?
    );

    return ans;
  }
  factory Data.fromVerfictionJson(Map<String, dynamic> json) {
    print('Verification JSON: $json');

    return Data(
      id: json['id'] as dynamic,
      role: json['role'] as String,
      isApproved: json['isApproved'] as dynamic,
      token: json['token'] as String,
      firstName: json['first_name'] as String? ?? "",
      lastName: json['last_name'] as String? ?? "",
      imagePath: json['image_path'] as dynamic,
      accountStatus: json['account_status'] as dynamic,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Data({this.firstName,
      this.lastName,
      this.accountStatus,
       this.id,
       this.role,
       this.isApproved,
       this.token,
       this.email,
       this.phone,
      this.imagePath});

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'isApproved': isApproved,
        'token': token,
      };
}
