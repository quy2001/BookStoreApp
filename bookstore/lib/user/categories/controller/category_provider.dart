import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../base/controller/base_provider.dart';
import '../model/category_response.dart';
import '../service/category_service.dart';


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
      categoryArr.insert(0, Category(id: 0, name: "Tất cả"));
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