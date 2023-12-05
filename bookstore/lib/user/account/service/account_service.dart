import 'package:dio/dio.dart';
import '../../../base/service/base_service.dart';
import '../../../base/service/services_url.dart';
import '../model/account_response.dart';

class AccountService extends BaseService {
  AccountService(Dio client) : super(client);

  Future<Account> getAccount(int id) async {
    final result = await client
        .fetch<Map<String, dynamic>>(setStreamType<AccountResponse>(Options(
      method: 'GET',
    ).compose(client.options, '${ServicesUrl.getAccount}/$id')));
    return AccountResponse.fromJson(result.data!).data;
  }
}