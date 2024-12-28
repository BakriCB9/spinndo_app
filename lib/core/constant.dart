class ApiConstant {
  static const String baseUrl = 'https://countquik.eu';
  static const String loginEndPoint = '/login';
  static const String registerClientEndPotint = '/registerClient';
  static const String verifyCodeEndPoint = '/verifyCode';
  static const String resendCodeEndPoint = '/resendCode';
  static const String resetPasswordEndPoint = '/resetPassword';
  static const String registerServiceProviderEndPoint =
      '/registerServiceProvider';
  static const String profilCelientEndPotint = '/profile/client';
  static const String profileServiceProviderEndPoint = '/profile/provider';
  static const String getServices = '/services/getfilter';
  static const String getAllCountries = '/countries/getAll';
  static const String getAllCategory = '/categories/getAll';
  static const String logoutEndPoint = '/logout';
  static const  String googleMapApiKey =
      'AIzaSyDLKgjHRJUu_v5A0GLTIddfD-B0tXAiKoQ';
  static const String updateClientProfile = '/profile/client/update';
  static const String updateProviderProfile = '/profile/provider/update';
  static const String imageProfile = '/profile/updateMyImage';
  static const String getAllNotification='/myNotification';
  static const String deleteMyAccount='/user';
  static const String deleteImage='/profile/updateMyImage';
}

class CacheConstant {
  static const String tokenKey = 'token';
  static const String emailKey = 'email';
  static const String semailKey = 'semail';
  static const String nameKey = 'name';
  static const String userId = 'user_id';
  static const String userRole = 'user_role';
  static const String imagePhoto = 'Image_photo';
  static const String imagePhotoFromLogin='image_phot';
}
