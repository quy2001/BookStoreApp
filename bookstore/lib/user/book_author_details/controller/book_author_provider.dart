import 'package:bookstore/base/controller/base_provider.dart';
import 'package:dio/dio.dart';

import '../../search_book/model/search_books_response.dart';
import '../service/book_author_service.dart';
final Dio dio = Dio();
class BookAuthorProvider extends BaseProvider<BookAuthorServices>{
  BookAuthorProvider (BookAuthorServices service) : super (service);

  List<SearchBook> listBook=[];
  Status statusBookAuthor = Status.none;
  Future<void> getBookAuthor(int idAuthor) async {
    try{
      startLoading((){
        statusBookAuthor=Status.loading;
      });
      listBook = await service.getListBookAuthor(idAuthor);
      if(listBook.isEmpty){
        receivedNoData(() {
          statusBookAuthor = Status.noData;
        });
      }else{
        finishLoading((){
          statusBookAuthor= Status.loaded;
        });
      }
    }on DioException catch (e){
      messagesError = e.message ?? 'Có lỗi hệ thống';
      receivedError((){
        statusBookAuthor = Status.error;
      });
    }
  }
}