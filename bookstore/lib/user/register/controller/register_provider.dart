import 'package:bookstore/base/controller/base_provider.dart';
import 'package:bookstore/user/register/model/register_response.dart';
import 'package:flutter/material.dart';

import '../../../base/service/dio_option.dart';
import 'package:dio/dio.dart';

import '../model/register_request.dart';
import '../service/register_service.dart';


class RegisterProvider extends BaseProvider<RegisterServices>{
  RegisterProvider(RegisterServices service) : super(service);

  int? success;

  Status statusRegister = Status.none;

  Future<void> register(BuildContext context, String name,String email, String password) async {
    try {
      startLoading(() {
        statusRegister = Status.loading;
      });
      final registerRequest = RegisterRequest(name: name,email: email, password: password);
      final registerService = RegisterServices(DioOption().createDio());
      success = await registerService.postRegister(request: registerRequest);
      finishLoading(() {
        statusRegister = Status.loaded;
      });
    } on DioException catch (e) {
      print(e.message);
      receivedError(() {
        statusRegister = Status.error;
      });
      print('Không thành công');
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