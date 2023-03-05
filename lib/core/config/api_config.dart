class ApiConfig {
  static const String localhost = "http://192.168.1.80:5000";
  static const String devServerUrl =
      "https://gis-land-registration-system.vercel.app";
  static const String apiUrl = "/api";
  static const String baseUrl = localhost + apiUrl;

  static const String loginUrl = "/login";

  static const String userUrl = "/user";
  static const String userUpdateUrl = "/update-user";
  static const String userImageUrl = "/user-image";
  static const String frontCitizenshipImageUrl = "/user-front-image";
  static const String backCitizenshipImageUrl = "/user-back-image";

  static const String landUrl = "/land";
  static const String addLandUrl = "/add-land";
   static const String userLandsUrl = "/user-lands";
}
