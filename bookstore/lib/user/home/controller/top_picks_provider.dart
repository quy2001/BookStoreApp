import 'package:bookstore/user/home/model/top_picks_response.dart';
import 'package:bookstore/user/home/service/top_picks_service.dart';
import 'package:dio/dio.dart';
import '../../../base/controller/base_provider.dart';
import 'package:flutter/material.dart';
class TopPickProvider extends BaseProvider<TopPickServices> {
  TopPickProvider(TopPickServices service) : super(service);
  List<TopPick> topPickArr = [];
  Future<void> getTopPick(BuildContext context) async {
    resetStatus();
    try {
      startLoading();
      topPickArr = await service.getTopPick();
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