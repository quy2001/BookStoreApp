import 'package:bookstore/user/search_book/model/search_books_response.dart';
import 'package:dio/dio.dart';

import '../../../base/service/base_service.dart';
import '../../../base/service/services_url.dart';
import '../model/search_book_request.dart';


class SearchBookServices extends BaseService {
  SearchBookServices(Dio client) : super(client);

  Future<List<SearchBook>> postSearchBook(
      {required SearchBookRequest request}) async {
    final result = await client.fetch<Map<String, dynamic>>(
        setStreamType<SearchBookResponse>(Options(
          method: 'POST',
        ).compose(client.options, ServicesUrl.postSearchBook,
            data: request.toJson())));
    return SearchBookResponse.fromJson(result.data!).data ?? [];
    //return ListDocumentResponse.fromJson(result.data!).data;
  }
}


// class BookServices extends BaseService {
//   BookServices(Dio client) : super(client);
//   Future<List<Book>> getBook(int i, String name) async {
//     final result = await client
//         .fetch<Map<String, dynamic>>(setStreamType<BookResponse>(Options(
//       method: 'GET',
//     ).compose(client.options, '${ServicesUrl.getBookPage}?page=$i&name=$name')));
//     return BookResponse.fromJson(result.data!).data ?? [];
//   }
// }