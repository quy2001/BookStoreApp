
import 'package:bookstore/user/home/model/author_id_response.dart';

import '../../../base/service/base_service.dart';
import 'package:dio/dio.dart';

import '../../../base/service/services_url.dart';
class AuthorIdServices extends BaseService {
  AuthorIdServices(Dio client) : super(client);

  Future<Data> getAuthorById(int id) async {
    final result = await client
        .fetch<Map<String, dynamic>>(setStreamType<AuthoByIdResponse>(Options(
      method: 'GET',
    ).compose(client.options,'${ServicesUrl.getAuthorByID}/$id' )));
    return AuthoByIdResponse.fromJson(result.data!).data;
  }
}