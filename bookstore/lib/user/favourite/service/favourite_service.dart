import 'package:bookstore/base/service/base_service.dart';
import 'package:bookstore/base/service/services_url.dart';
import 'package:bookstore/user/favourite/model/favourite_message_request.dart';
import 'package:dio/dio.dart';

import '../model/favourite_request.dart';
import '../model/favourite_response.dart';

class FavouriteServices extends BaseService{
  FavouriteServices(Dio client) : super(client);

  //yêu thích/bỏ yêu thích
  Future<String> postFavourite ({ required FavouriteRequest request}) async{
    final result = await client.fetch<Map<String, dynamic>>(
        setStreamType<FavouriteMessageRequest>(Options(
          method: 'POST',
        ).compose(client.options, ServicesUrl.postFavourite,data: request.toJson())));
    return FavouriteMessageRequest.fromJson(result.data!).message;
  }

  //lấy danh sách yêu thích.
  Future<List<Favourite>> getListFavourite(var idUser) async{
    final result = await client
        .fetch<Map<String,dynamic>>(setStreamType<FavouriteResponse>(Options(
      method: 'GET',
    ).compose(client.options, '${ServicesUrl.getFavourite}/$idUser')));
    return FavouriteResponse.fromJson(result.data!).data ?? [];
  }
}