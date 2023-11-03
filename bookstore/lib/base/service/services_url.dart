class ServicesUrl{
  static const String baseUrl = "http://10.0.2.2:8000";
  static const String postLogin = "$baseUrl/account/login";
  static const String postRegister = "$baseUrl/account/register";
  static const String getCategories = "$baseUrl/api/danh_sach_the_loai";
  static const String getAuthors = "$baseUrl/api/danh_sach_tac_gia";
  static const String getTopPicks = "$baseUrl/api/books";
  static const String getAuthorByID = "$baseUrl/api/tac_gia";
}