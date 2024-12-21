class Data {
  final dynamic id;
  final String role;
  final dynamic isApproved;
  final String token;
  final String? firstName;
  final String? lastName;
  final String?imagePath;

  factory Data.fromJson(Map<String, dynamic> json) { 
    print('we finish from  json now bakkkkkkkkkkkkkkkkkkkkkkkar 1111111111');
    print('json is now $json');
   print('the id is ${json['id'] as dynamic}');
   print('the role is ${json['role'] as String}');
   print('the approved is ${json['isApproved'] as dynamic}');
   print('the token is ${json['token'] as String}');
    print('firstname is ${ json['first_name']as String }');
    print('lastName is ${json['last_name'] as String}');
  // print('the image is ${json['image_path'] as String??"bbaaababa"}');
   final ans=  Data(
        id: json['id'] as dynamic,
        role: json['role'] as String,
        isApproved: json['isApproved'] as dynamic,
        token: json['token'] as String,
        firstName: json['first_name'] as String ?? "",
        lastName: json['last_name'] as String ?? "",
        imagePath:json['image_path'] as String??"",
      );
      print('we finish from  json now bakkkkkkkkkkkkkkkkkkkkkkkar 2222222222222222222');
     return ans;
      }
  factory Data.fromVerfictionJson(Map<String, dynamic> json) => Data(
        id: json['id'] as dynamic,
        role: json['role'] as String,
        isApproved: json['isApproved'] as dynamic,
        token: json['token'] as String,
      );
  Data(
      {this.firstName,
      this.lastName,
      required this.id,
      required this.role,
      required this.isApproved,
      required this.token,
      this.imagePath
      });

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'isApproved': isApproved,
        'token': token,
      };
}
