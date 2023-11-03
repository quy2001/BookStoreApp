
import '../../../base/service/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../../base/service/services_url.dart';
import '../model/login_user_request.dart';
import '../model/login_user_response.dart';

class LoginUserServices extends BaseService {
  LoginUserServices(Dio client) : super(client);
  String? token;
  Future<Data?> postLogin({required LoginUserRequest request}) async {
    final result = await client.fetch<Map<String, dynamic>>(
        setStreamType<LoginUserResponse>(Options(
          method: 'POST',
        ).compose(client.options,ServicesUrl.postLogin, data: request.toJson())));
    token = result.data!['data']['token'];
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token!);
    print('----------------------token before : $token');
    return LoginUserResponse.fromJson(result.data!).data;
  }
}