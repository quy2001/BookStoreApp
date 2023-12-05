import '../../../base/service/base_service.dart';
import 'package:dio/dio.dart';
import '../../../base/service/services_url.dart';
import '../../search_book/model/search_books_response.dart';

class BookAuthorServices extends BaseService {
  BookAuthorServices(Dio client) : super(client);
  Future<List<SearchBook>> getListBookAuthor(int idAuthor) async{
    final result = await client
        .fetch<Map<String,dynamic>>(setStreamType<SearchBookResponse>(Options(
      method: 'GET',
    ).compose(client.options, '${ServicesUrl.getBookByIdAuthor}/$idAuthor')));
    return SearchBookResponse.fromJson(result.data!).data ?? [];
  }
}