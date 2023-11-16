import 'package:bookstore/base/controller/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../model/author_response.dart';
import '../service/author_service.dart';
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
      authorArr.insert(0,Author(id: 0, name: 'Tất cả'));
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