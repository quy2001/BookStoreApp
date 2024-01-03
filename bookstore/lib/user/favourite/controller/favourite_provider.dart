import 'package:bookstore/user/favourite/model/favourite_request.dart';
import 'package:bookstore/user/favourite/service/favourite_service.dart';
import 'package:dio/dio.dart';
import '../../../base/controller/base_provider.dart';
import '../../login_user/service/secure_storage.dart';
import '../model/favourite_response.dart';
class FavouriteProvider extends BaseProvider<FavouriteServices> {
  FavouriteProvider(FavouriteServices service) : super(service);
  late String message = '';
  late List<Favourite> listFavourite = [];
  bool statusFa = false;

  bool setFavourite (bool statusFavourite,int idBook){
    statusFa = statusFavourite;
    addFavourite(idBook);
    return statusFa = !statusFa;
  }


  //tra ve thong bao them thanh cong
  Future<void> addFavourite(int idBook) async {
    resetStatus();
    try{
      startLoading();
      var keyidUser = await SecureStorage().read('idUser');
      message = await service.postFavourite(request: FavouriteRequest(idUser: int.parse(keyidUser), idBook: idBook));
      finishLoading();
    }on DioException catch (e) {
      messagesError = e.message ?? 'Có lỗi hệ thống';
      receivedError();
    }
  }
  //lấy danh sách yêu thích
  Future<void> getListFavourite() async{
    resetStatus();
    try{
      startLoading();
      var keyidUser = await SecureStorage().read('idUser');
      listFavourite = await service.getListFavourite(int.parse(keyidUser));
      if(listFavourite.isEmpty){
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
