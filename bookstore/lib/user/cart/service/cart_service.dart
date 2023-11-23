import 'package:bookstore/base/service/base_service.dart';
import 'package:dio/dio.dart';

import '../../../base/service/services_url.dart';
import '../model/cart_notification.dart';
import '../model/cart_request.dart';
import '../model/cart_response.dart';
class CartServices extends BaseService{

  CartServices(Dio client) : super(client);

  //them gio hang
  Future<String> postAddCart({required CartRequest request}) async {
    final result = await client.fetch<Map<String, dynamic>>(
        setStreamType<CartNotification>(Options(
          method: 'POST',
        ).compose(client.options,ServicesUrl.postAddCart, data: request.toJson())));
    return CartNotification.fromJson(result.data!).message;
  }

  //lay danh sach gio hang
  Future<List<Cart>> getListCart(var idUser) async{
    final result = await client
        .fetch<Map<String,dynamic>>(setStreamType<CartResponse>(Options(
      method: 'GET',
    ).compose(client.options, '${ServicesUrl.getListCart}/$idUser')));
    return CartResponse.fromJson(result.data!).data ?? [];
  }
}