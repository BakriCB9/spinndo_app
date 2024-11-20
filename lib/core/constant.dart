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
  static const String profileServiceProviderEndPoint =    '/profile/provider';
}


class CacheConstant {
  static const String tokenKey = 'token';
  static const String userId='user_id';
  static const String userRole='user_role';
}
