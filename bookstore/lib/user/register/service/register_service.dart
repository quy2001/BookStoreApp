import 'package:dio/dio.dart';

import '../../../base/service/base_service.dart';
import '../../../base/service/services_url.dart';
import '../model/register_request.dart';
import '../model/register_response.dart';


class RegisterServices extends BaseService {
  RegisterServices(Dio client) : super(client);
  Future<int?> postRegister({required RegisterRequest request}) async {
    final result = await client.fetch<Map<String, dynamic>>(
        setStreamType<RegisterResponse>(Options(
          method: 'POST',
        ).compose(client.options,ServicesUrl.postRegister, data: request.toJson())));
    return RegisterResponse.fromJson(result.data!).success;
  }
}