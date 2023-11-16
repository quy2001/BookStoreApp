import 'package:bookstore/base/service/base_service.dart';
import 'package:bookstore/base/service/services_url.dart';
import 'package:dio/dio.dart';

import '../model/author_response.dart';
class AuthorService extends BaseService{
  AuthorService (Dio client) : super(client);
  Future<List<Author>> getAuthor() async{
    final result = await client
        .fetch<Map<String,dynamic>>(setStreamType<AuthorResponse>(Options(
      method: 'GET',
    ).compose(client.options, ServicesUrl.getAuthors)));
    return AuthorResponse.fromJson(result.data!).data;
  }
}