import 'package:bookstore/user/bookcase/model/bookcaseRequest.dart';
import 'package:bookstore/user/bookcase/model/bookcaseResponse.dart';
import 'package:bookstore/user/bookcase/service/bookcase_service.dart';
import '../../../base/controller/base_provider.dart';
import '../../login_user/service/secure_storage.dart';
import 'package:dio/dio.dart';
class BookcaseProvider extends BaseProvider<BookcaseServices> {
  BookcaseProvider(BookcaseServices service) : super(service);

  late List<Bookcase> listBookcase = [];
  String name ='';
  Status statusBookCase = Status.none;
  Future<void> getListBookcase() async{
    resetStatus();
    try{
      startLoading((){
        statusBookCase = Status.loading;
      });
      var keyidUser = await SecureStorage().read('idUser');
      listBookcase = await service.postBookcase(
          request: BookcaseRequest(
              idUser: int.parse(keyidUser),
              bname: name));
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