
import 'package:bookstore/user/home/model/top_picks_response.dart';
import 'package:bookstore/user/home/service/top_picks_service.dart';
import 'package:dio/dio.dart';
import '../../../base/controller/base_provider.dart';
import 'package:bookstore/user/home/model/author_id_response.dart';
import 'package:bookstore/user/home/service/author_id_service.dart';
import 'package:flutter/material.dart';
class AuthorByIdProvider extends BaseProvider<AuthorIdServices> {
  AuthorByIdProvider(AuthorIdServices service) : super(service);
  late Data data;
  Future<void> getAuthorById(BuildContext context,int id) async {
    resetStatus();
    try {
      startLoading();
      data = await service.getAuthorById(id);
      finishLoading();
    } on DioException catch (e) {
      messagesError = e.message ?? 'Có lỗi hệ thống';
      receivedError();
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return DialogBase(title:"Thất bại", icon: AppAssets.iconFail,content: "Có lỗi hệ thống",);
      //   },
      // );
    }
  }
}

// import 'package:bookstore/base/controller/base_provider.dart';
//
// import 'package:dio/dio.dart';
//
// final Dio dio = Dio();
// class AuthorByIdProvider extends BaseProvider<AuthorIdServices>{
//   AuthorByIdProvider (AuthorIdServices service) : super(service);
//     late Data data;
//   Status statusAuthorid = Status.none;
//   Future<void> getAuthorById(int id) async {
//     try{
//       startLoading((){
//         statusAuthorid=Status.loading;
//       });
//       data = await service.getAuthorById(id);
//       finishLoading((){
//         statusAuthorid= Status.loaded;
//       });
//     }on DioException catch (e){
//       messagesError = e.message ?? 'Có lỗi hệ thống';
//       receivedError((){
//         statusAuthorid = Status.error;
//       });
//     }
//   }
//
// }