import 'package:bookstore/user/home/model/category_response.dart';
import 'package:bookstore/user/home/service/category_service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../base/controller/base_provider.dart';


final Dio dio = Dio();
class CategoryProvider extends BaseProvider<CategoryServices> {
  CategoryProvider(CategoryServices service) : super(service);
  // late List<Category> category;
  List<Category> categoryArr = [];
  Status statusCategory = Status.none;
  Future<void> getCategory(BuildContext context) async {
    // resetStatus();
    try {
      startLoading((){
        statusCategory = Status.loading;
      });
      categoryArr = await service.getCategory();
      finishLoading((){
        statusCategory = Status.loaded;
      });
    } on DioException catch (e) {
      messagesError = e.message ?? 'Co loi he thong';
      receivedError(() {
        statusCategory = Status.error;
      });
    }
  }
}