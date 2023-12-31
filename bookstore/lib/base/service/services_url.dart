class ServicesUrl{
  static const String baseUrl = "http://10.0.2.2:8000";
  static const String postLogin = "$baseUrl/account/login";
  static const String postRegister = "$baseUrl/account/register";

  static const String getCategories = "$baseUrl/api/danh_sach_the_loai";
  static const String getAuthors = "$baseUrl/api/danh_sach_tac_gia";

  static const String getTopPicks = "$baseUrl/api/books";
  static const String getBookDetail = "$baseUrl/api/book";//lấy sách theo id
  static const String getAuthorByID = "$baseUrl/api/tac_gia";
  // static const String getBookPage = "$baseUrl/api/books_page";

  static const String postSearchBook = "$baseUrl/api/books/search";

  static const String postAddCart = "$baseUrl/api/cart/add";
  static const String getListCart = "$baseUrl/api/cart/getList";
  static const String deleteCart = "$baseUrl/api/cart/delete";

  static const String getAccount = "$baseUrl/user/userDetail";

  static const String getBookByIdCategory = "$baseUrl/api/booksCategory";
  static const String getBookByIdAuthor = "$baseUrl/api/bookAuthor";

  // static const String getListMyBook = "$baseUrl/api/cart/getList/myBook";//k gọi đến nữa
  static const String postSearchMyBook ="$baseUrl/api/mybook/search";


}