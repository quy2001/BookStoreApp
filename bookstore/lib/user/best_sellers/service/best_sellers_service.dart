import 'package:dio/dio.dart';
import '../../../base/service/base_service.dart';
import '../../../base/service/services_url.dart';
import '../model/best_sellers_request.dart';
import '../model/best_sellers_response.dart';

class BestSellersServices extends BaseService {
  BestSellersServices(Dio client) : super(client);

  Future<List<BestSellers>> postBestSellers(
      {required BestSellersRequest request}) async {
    final result = await client.fetch<Map<String, dynamic>>(
        setStreamType<BestSellersResponse>(Options(
          method: 'POST',
        ).compose(client.options, ServicesUrl.postBestSellers,
            data: request.toJson())));
    return BestSellersResponse.fromJson(result.data!).data ?? [];
  }
}