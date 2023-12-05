import 'package:dio/dio.dart';
import '../../../base/controller/base_provider.dart';
import '../../login_user/service/secure_storage.dart';
import '../model/account_response.dart';
import '../service/account_service.dart';

class AccountProvider extends BaseProvider<AccountService>{
  AccountProvider(AccountService service) : super(service);
  late Account account;
  Status statusAccount = Status.none;

  Future<void> getAccount() async{
    resetStatus();
    try {
      startLoading();
      var keyidUser = await SecureStorage().read('idUser');
      account = await service.getAccount(int.parse(keyidUser));
      finishLoading();
    }on DioException catch (e){
      messagesError = e.message ?? 'Có lỗi hệ thống';
      receivedError(() {
        statusAccount = Status.error;
      });
    }
  }

}