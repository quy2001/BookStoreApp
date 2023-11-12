import 'package:bookstore/base/controller/base_provider.dart';
import 'package:bookstore/user/login_user/service/login_user_services.dart';
import 'package:flutter/material.dart';

import '../../../base/service/dio_option.dart';
import '../../../base/widgets/dialog_widget.dart';
import '../../../common/values/assets.dart';
import '../../main_tab/main_tab_screen.dart';
import '../model/login_user_request.dart';
import 'package:dio/dio.dart';

import '../model/login_user_response.dart';

class LoginUserProvider extends BaseProvider<LoginUserServices>{
  LoginUserProvider(LoginUserServices service) : super(service);

  Data? _user;
  Data? get user => _user;

  Status statusLogin = Status.none;
  void setUser(Data? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> login(BuildContext context, String name, String password) async {
    try {
      startLoading(() {
        statusLogin = Status.loading;
      });
      final loginRequest = LoginUserRequest(name: name, password: password);
      final loginService = LoginUserServices(DioOption().createDio(addToken: false));
      final user = await loginService.postLogin(request: loginRequest);

      setUser(user);
      finishLoading(() {
        statusLogin = Status.loaded;
        showDialog(context: context, builder: (context){
          return DialogWidget(
            title: 'Thành công',
            icon: AppAssets.icoDialogSuccess,
            cancelButton: false,
            content: 'Bạn đã đăng nhập thành công',
            function: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => MainTabScreen()));
            },
          );
        }
        );
      });
    } on DioException catch (e) {
      print(e.message);
      receivedError(() {
        statusLogin = Status.error;
      });
      showDialog(context: context, builder: (context){
        return DialogWidget(
          title: 'Thất bại',
          icon: AppAssets.icoDialogFail,
          cancelButton: false,
          content: 'Sai tên đăng nhập hoặc mật khẩu! Vui lòng thử lại',
        );
      }
      );
    }
  }
}