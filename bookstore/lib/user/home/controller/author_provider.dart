import 'package:bookstore/base/controller/base_provider.dart';
import 'package:bookstore/user/home/service/author_service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../model/author_response.dart';
final Dio dio = Dio();
class AuthorProvider extends BaseProvider<AuthorService>{
  AuthorProvider (AuthorService service) : super (service);

  List<Author> authorArr = [];
  Status statusAuthor = Status.none;
  Future<void> getAuthor(BuildContext context) async {
    try{
      startLoading((){
        statusAuthor=Status.loading;
      });
      authorArr = await service.getAuthor();
      finishLoading((){
        statusAuthor= Status.loaded;
      });
    }on DioException catch (e){
      messagesError = e.message ?? 'Có lỗi hệ thống';
      receivedError((){
        statusAuthor = Status.error;
      });
    }
  }

}