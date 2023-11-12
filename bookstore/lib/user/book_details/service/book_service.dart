import 'package:bookstore/base/service/base_service.dart';
import 'package:bookstore/base/service/services_url.dart';
import 'package:dio/dio.dart';

import '../model/book_response.dart';

class BookService extends BaseService {
  BookService(Dio client) : super(client);

  Future<Book> getBookDetail(int id) async {
    final result = await client
        .fetch<Map<String, dynamic>>(setStreamType<BookResponse>(Options(
      method: 'GET',
    ).compose(client.options, '${ServicesUrl.getBookDetail}/$id')));
    return BookResponse.fromJson(result.data!).data;
  }
}
