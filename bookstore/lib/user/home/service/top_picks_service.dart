
import 'package:bookstore/user/home/model/top_picks_response.dart';
import 'package:dio/dio.dart';

import '../../../base/service/base_service.dart';
import '../../../base/service/services_url.dart';

class TopPickServices extends BaseService {
  TopPickServices(Dio client) : super(client);
  Future<List<TopPick>> getTopPick() async {
    final result = await client
        .fetch<Map<String, dynamic>>(setStreamType<TopPickResponse>(Options(
      method: 'GET',
    ).compose(client.options, ServicesUrl.getTopPicks)));
    return TopPickResponse.fromJson(result.data!).data;
  }
}