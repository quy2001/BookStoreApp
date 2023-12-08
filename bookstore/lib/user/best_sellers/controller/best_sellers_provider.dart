import 'package:bookstore/user/best_sellers/model/best_sellers_request.dart';
import 'package:bookstore/user/best_sellers/model/best_sellers_response.dart';
import 'package:dio/dio.dart';

import '../../../base/controller/base_provider.dart';
import '../../login_user/service/secure_storage.dart';
import '../service/best_sellers_service.dart';

class BestSellersProvider extends BaseProvider<BestSellersServices> {
  BestSellersProvider(BestSellersServices service) : super(service);

  late List<BestSellers> listBestSellers = [];
  String name ='';
  // Status statusBestSellers = Status.none;

  void searchBestSellers(String nameSearch){
    if(nameSearch != ''){
      name = nameSearch;
      listBestSellers = [];
      getListBestSellers();
    }else {
      name = '';
      listBestSellers = [];
      getListBestSellers();
    }
  }

  Future<void> getListBestSellers() async{
    resetStatus();
    try{
      startLoading();
      var keyidUser = await SecureStorage().read('idUser');
      listBestSellers = await service.postBestSellers(
          request: BestSellersRequest(
              idUser: int.parse(keyidUser),
              bname: name));
      if(listBestSellers.isEmpty){
        receivedNoData();
      }else{
        finishLoading();
      }
    }on DioException catch (e){
      messagesError = e.message ?? 'Có lỗi hệ thống';
      receivedError();
    }
  }

}

