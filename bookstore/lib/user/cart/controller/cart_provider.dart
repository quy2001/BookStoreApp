import 'package:bookstore/base/controller/base_provider.dart';
import 'package:bookstore/user/cart/model/cart_response.dart';
import 'package:bookstore/user/cart/service/cart_service.dart';

import '../../login_user/service/secure_storage.dart';
import '../model/cart_request.dart';
import 'package:dio/dio.dart';
class CartProvider extends BaseProvider<CartServices> {
  CartProvider(CartServices service) : super(service);
  late String message = '';
  late List<Cart> listCart = [];

  //tra ve thong bao them thanh cong
  Future<void> addCart(
    int idUser,
    int idBook,
  ) async {
    resetStatus();
    try{
      startLoading();
      message = await service.postAddCart(
          request: CartRequest(idUser: idUser, idBook: idBook, status: false));
      finishLoading();
    }on DioException catch (e) {
      messagesError = e.message ?? 'Co loi he thong';
      receivedError();
    }
  }
  //lay danh sach gio hang
  Future<void> getListCart() async{
    resetStatus();
    try{
      startLoading();
      var keyidUser = await SecureStorage().read('idUser');
      // print('----------------------keyUser: $keyidUser');
      listCart = await service.getListCart(keyidUser);
      if(listCart.isEmpty){
        receivedNoData();
      }else{
        finishLoading();
      }
    }on DioException catch (e){
      messagesError = e.message ?? 'Co loi he thong';
      receivedError();
    }
  }
}
