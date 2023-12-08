import 'package:dio/dio.dart';
import '../../../base/controller/base_provider.dart';
import 'package:flutter/material.dart';

import '../../login_user/service/secure_storage.dart';
import '../../search_book/model/search_book_request.dart';
import '../../search_book/model/search_books_response.dart';
import '../../search_book/service/book_service.dart';
class TopPickProvider extends BaseProvider<SearchBookServices> {
  TopPickProvider(SearchBookServices service) : super(service);
  // List<TopPick> topPickArr = [];

  List<SearchBook> listBookDisplay=[];
  String name = '';
  Status statusBook = Status.none;
  int page =1;
  int idAuthor = 0;
  int idCategory =0;

  Future<void> getTopPick(BuildContext context) async {
    resetStatus();
    try {
      startLoading();
      var keyidUser = await SecureStorage().read('idUser');
      listBookDisplay = await service.postSearchBook(request: SearchBookRequest(
          idAuthor: idAuthor,
          idCategory: idCategory,
          page: page,
          name: name,
          userid: int.parse(keyidUser))
      );
      if(listBookDisplay.isEmpty){
        receivedNoData();
      }else{
        finishLoading();
      }
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