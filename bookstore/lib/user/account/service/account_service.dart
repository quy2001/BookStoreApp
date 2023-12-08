import 'package:bookstore/user/account/model/edit_account_response.dart';
import 'package:dio/dio.dart';
import '../../../base/service/base_service.dart';
import '../../../base/service/services_url.dart';
import '../model/account_response.dart';
import '../model/edit_account_request.dart';

class AccountService extends BaseService {
  AccountService(Dio client) : super(client);

  //lấy tài khoản người dùng
  Future<Account> getAccount(int id) async {
    final result = await client
        .fetch<Map<String, dynamic>>(setStreamType<AccountResponse>(Options(
      method: 'GET',
    ).compose(client.options, '${ServicesUrl.getAccount}/$id')));
    return AccountResponse.fromJson(result.data!).data;
  }

  //sửa tài khoản người dùng
  Future<DataAccount> editAccount({required EditAccountRequest request}) async {
    final result = await client.fetch<Map<String, dynamic>>(
        setStreamType<EditAccountResponse>(Options(
      method: 'PUT',
    ).compose(client.options, ServicesUrl.editAccount,
            data: request.toJson())));
    return EditAccountResponse.fromJson(result.data!).data;
  }
}
