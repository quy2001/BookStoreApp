import 'package:bookstore/user/bookcase/service/bookcase_service.dart';
import '../../../base/controller/base_provider.dart';
import '../../cart/model/cart_response.dart';
import '../../login_user/service/secure_storage.dart';
import 'package:dio/dio.dart';
class BookcaseProvider extends BaseProvider<BookcaseServices> {
  BookcaseProvider(BookcaseServices service) : super(service);

  late List<Cart> listBookcase = [];
  Status statusBookCase = Status.none;
  //lay danh sach gio hang
  Future<void> getListBookcase() async{
    resetStatus();
    try{
      startLoading((){
        statusBookCase = Status.loading;
      });
      var keyidUser = await SecureStorage().read('idUser');
      listBookcase = await service.getBookcase(keyidUser);
      if(listBookcase.isEmpty){
        receivedNoData((){
          statusBookCase = Status.noData;
        });
      }else{
        finishLoading((){
          statusBookCase = Status.loaded;
        });
      }
    }on DioException catch (e){
        messagesError = e.message ?? 'Có lỗi hệ thống';
        receivedError(() {
          statusBookCase = Status.error;
        });
    }
  }

}