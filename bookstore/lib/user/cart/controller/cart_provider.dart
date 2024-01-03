import 'package:bookstore/base/controller/base_provider.dart';
import 'package:bookstore/user/cart/model/cart_response.dart';
import 'package:bookstore/user/cart/service/cart_service.dart';
import 'package:flutter/material.dart';
import '../../../base/widgets/dialog_widget.dart';
import '../../../common/values/assets.dart';
import '../../login_user/service/secure_storage.dart';
import '../model/cart_request.dart';
import 'package:dio/dio.dart';
class CartProvider extends BaseProvider<CartServices> {
  CartProvider(CartServices service) : super(service);
  late String message = '';
  late String messageDele = '';
  late List<Cart> listCart = [];

  totalPrice(){
    int total = 0;
    for (int i = 0; i < listCart.length; i++){
      total = total + listCart[i].bprice;
    }
    return total;
  }

  //tra ve thong bao them thanh cong
  Future<void> addCart(BuildContext context,int idBook,) async {
    resetStatus();
    try{
      startLoading();
      var keyidUser = await SecureStorage().read('idUser');
      message = await service.postAddCart(
          request: CartRequest(idUser: int.parse(keyidUser) , idBook: idBook, status: false));
      finishLoading((){
        showDialog(context: context, builder: (context){
          return DialogWidget(
            title: 'Thông báo',
            icon: AppAssets.icoDialogSuccess,
            cancelButton: false,
            content: 'Thêm vào giỏ hàng thành công',
          );
        }
        );
      });
    }on DioException catch (e) {
      messagesError = e.message ?? 'Có lỗi hệ thống';
      receivedError();
      showDialog(context: context, builder: (context){
        return DialogWidget(
          title: 'Thông báo',
          icon: AppAssets.icoDialogFail,
          cancelButton: false,
          content: 'Sách đã có trong giỏ hàng',
        );
      }
      );
    }
  }
  //lay danh sach gio hang
  Future<void> getListCart() async{
    resetStatus();
    try{
      startLoading();
      var keyidUser = await SecureStorage().read('idUser');
      listCart = await service.getListCart(keyidUser);
      if(listCart.isEmpty){
        receivedNoData();
      }else{
        finishLoading();
      }
    }on DioException catch (e){
      messagesError = e.message ?? 'Có lỗi hệ thống';
      receivedError();
    }
  }
  //tra ve thong bao xoa thanh cong
  Future<void> deleteCart(int id) async {
    resetStatus();
    try{
      startLoading();
      messageDele = await service.deleteCart(id);
      finishLoading();
      getListCart();
    }on DioException catch (e) {
      messagesError = e.message ?? 'Co loi he thong';
      receivedError();
    }
  }

}
