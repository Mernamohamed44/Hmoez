class ApiConstants {
  static const String apiBaseUrl = "https://homez.azsystems.tech/api/";
  static const String imagesBaseUrl = "${apiBaseUrl}upload/products/image/";

  static const String register = "${apiBaseUrl}user-register";
  static const String sendOtp = "${apiBaseUrl}confirm-code";
  static const String reSendOtp = "${apiBaseUrl}resend-otp";
  static const String login = "${apiBaseUrl}user-login";
  static const String sendCode = "${apiBaseUrl}send-code";
  static const String confirmCode = "${apiBaseUrl}confirm-code";
  static const String checkCode = "${apiBaseUrl}check-code";
  static const String resetPassword = "${apiBaseUrl}reset-password";
  static const String loginSocial = "${apiBaseUrl}user-login-social";
  static const String logout = "${apiBaseUrl}logout";
  static const String showProfile = "${apiBaseUrl}show-profile";
  static const String updateProfile = "${apiBaseUrl}update-profile";
  static const String sendOtpToUpdatePhone =
      "${apiBaseUrl}send-otp-to-check-phone";
  static const String updatePhone = "${apiBaseUrl}update-phone";
  static const String editPassword = "${apiBaseUrl}edit-password";

  //home
  static const String showHome = "${apiBaseUrl}home";
}
