import 'package:bookstore/base/controller/base_provider.dart';
import 'package:bookstore/user/book_details/model/book_response.dart';
import 'package:bookstore/user/book_details/service/book_service.dart';
import 'package:dio/dio.dart';

class BookProvider extends BaseProvider<BookService>{
  BookProvider(BookService service) : super(service);
  late Book book;
  Status statusBookDetail = Status.none;

  Future<void> getBookDetail(int idBook) async{
    resetStatus();
    try {
      startLoading();
      book = await service.getBookDetail(idBook);
      finishLoading();
    }on DioException catch (e){
      messagesError = e.message ?? 'Có lỗi hệ thống';
      receivedError(() {
        statusBookDetail = Status.error;
      });
    }
  }

}