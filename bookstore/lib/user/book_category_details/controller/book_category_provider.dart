import 'package:bookstore/base/controller/base_provider.dart';
import 'package:bookstore/user/book_category_details/service/book_category_service.dart';
import 'package:dio/dio.dart';

import '../../search_book/model/search_books_response.dart';

// final Dio dio = Dio();
class BookCategoryProvider extends BaseProvider<BookCategoryServices>{
  BookCategoryProvider (BookCategoryServices service) : super (service);

  List<SearchBook> listBook=[];
  Status statusBookCategory = Status.none;
  Future<void> getBookCategory(int idCategory) async {
    try{
      startLoading((){
        statusBookCategory=Status.loading;
      });
      listBook = await service.getListBookCategory(idCategory);
      if(listBook.isEmpty){
        receivedNoData(() {
          statusBookCategory = Status.noData;
        });
      }else{
        finishLoading((){
          statusBookCategory= Status.loaded;
        });
      }
    }on DioException catch (e){
      messagesError = e.message ?? 'Có lỗi hệ thống';
      receivedError((){
        statusBookCategory = Status.error;
      });
    }
  }
}