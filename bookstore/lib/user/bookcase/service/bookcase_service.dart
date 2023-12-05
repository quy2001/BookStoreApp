import '../../../base/service/base_service.dart';
import 'package:dio/dio.dart';

import '../../../base/service/services_url.dart';
import '../../cart/model/cart_response.dart';
class BookcaseServices extends BaseService{
  BookcaseServices(Dio client) : super(client);

  Future<List<Cart>> getBookcase(var idUser) async{
    final result = await client
        .fetch<Map<String,dynamic>>(setStreamType<CartResponse>(Options(
      method: 'GET',
    ).compose(client.options, '${ServicesUrl.getListMyBook}/$idUser')));
    return CartResponse.fromJson(result.data!).data ?? [];
  }
}