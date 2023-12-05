import 'package:bookstore/user/bookcase/model/bookcaseRequest.dart';
import 'package:bookstore/user/bookcase/model/bookcaseResponse.dart';

import '../../../base/service/base_service.dart';
import 'package:dio/dio.dart';

import '../../../base/service/services_url.dart';
class BookcaseServices extends BaseService{
  BookcaseServices(Dio client) : super(client);

  Future<List<Bookcase>> postBookcase({required BookcaseRequest request}) async{
    final result = await client.fetch<Map<String,dynamic>>(setStreamType<BookcaseResponse>(Options(
      method: 'POST',
    ).compose(client.options, ServicesUrl.postSearchMyBook,data: request.toJson())));
    return BookcaseResponse.fromJson(result.data!).data ?? [];
  }
}