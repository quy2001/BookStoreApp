import 'package:bookstore/user/account/model/edit_account_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../base/controller/base_provider.dart';
import '../../../base/widgets/dialog_widget.dart';
import '../../../common/values/assets.dart';
import '../../login_user/service/secure_storage.dart';
import '../model/account_response.dart';
import '../model/edit_account_response.dart';
import '../service/account_service.dart';

class AccountProvider extends BaseProvider<AccountService>{
  AccountProvider(AccountService service) : super(service);
  late Account account;
  late String message = '';
  late DataAccount dataAccount = DataAccount(id: 0, name: '', email: '');
  Status statusAccount = Status.none;

  //lấy tài khoản người dùng
  Future<void> getAccount() async{
    resetStatus();
    try {
      startLoading();
      var keyidUser = await SecureStorage().read('idUser');
      account = await service.getAccount(int.parse(keyidUser));
      finishLoading();
    }on DioException catch (e){
      messagesError = e.message ?? 'Có lỗi hệ thống';
      receivedError();
    }
  }
  //sửa tài khoản người dùng
  Future<void> editAccount(BuildContext context,String name, String email) async{
    resetStatus();
    try{
      startLoading();
      var keyidUser = await SecureStorage().read('idUser');
      dataAccount = await service.editAccount(request: EditAccountRequest(
          id: int.parse(keyidUser),
          name: name,
          email: email)
      );
      finishLoading((){
        showDialog(context: context, builder: (context){
          SecureStorage().delete('name');
          SecureStorage().delete('password');
          return DialogWidget(
            title: 'Thông báo',
            icon: AppAssets.icoDialogSuccess,
            cancelButton: false,
            content: 'Cập nhật thông tin người dùng thành công',
          );
        }
        );
      });
    }on DioException catch (e){
      messagesError = e.message ?? 'Có lỗi hệ thống';
      receivedError();
    }
  }


}