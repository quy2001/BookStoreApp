import 'package:dio/dio.dart';
import '../../../base/service/base_service.dart';
import '../../../base/service/services_url.dart';
import '../model/category_response.dart';

class CategoryServices extends BaseService {
  CategoryServices(Dio client) : super(client);
  Future<List<Category>> getCategory() async {
    final result = await client
        .fetch<Map<String, dynamic>>(setStreamType<CategoryResponse>(Options(
      method: 'GET',
    ).compose(client.options, ServicesUrl.getCategories)));
    return CategoryResponse.fromJson(result.data!).data ?? [];
  }
}
