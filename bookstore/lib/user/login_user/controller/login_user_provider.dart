import 'package:bookstore/base/controller/base_provider.dart';
import 'package:bookstore/user/login_user/service/login_user_services.dart';
import 'package:flutter/material.dart';

import '../../../base/service/dio_option.dart';
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
      });
    } on DioException catch (e) {
      print(e.message);
      receivedError(() {
        statusLogin = Status.error;
      });
      print('Sai tên đăng nhập');
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return DialogBase(
      //         title: 'Thông báo',
      //         content: 'Lorem ispum',
      //         icon: AppAssets.icoNotice,
      //         button: true,
      //       );
      //     });
    }
  }
}