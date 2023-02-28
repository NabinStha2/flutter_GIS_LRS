class ApiConfig {
  static const serverUrl = "https://api.pokharabuzz.com";

  static const baseUrl = "$serverUrl/api";

  //user auth
  static const userAuthUrl = "/user-auth";
  static const loginUrl = "/login";
  static const signUpUrl = "/signup";
  static const forgotPasswordUrl = "/forgotpassword";
  static const passwordUrl = "/password";
  static const otpVerifyUrl = "/verify-OTP";

  //user
  static const userUrl = "/user";

  //blog
  static const blogUrl = "/blog";
  static const blogSearchUrl = "?search=";
  static const bloglimitUrl = "?limit=";
  static const blogPageUrl = "&page=";

  //comment
  static const commentUrl = "/comment";
  static const commentIdUrl = "/comment?blocId=";
}
