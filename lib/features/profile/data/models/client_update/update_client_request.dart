class UpdateClientRequest{
  final String firstName;
  final  String lastName;
  UpdateClientRequest({required this.firstName,required this.lastName});
  Map<String ,dynamic>toJson()=>{
    "first_name":firstName,
    "last_name":lastName,
    "_method":'PUT'
  };
}