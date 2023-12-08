import 'package:bookstore/user/favourite/controller/favourite_provider.dart';
import 'package:bookstore/user/favourite/screen/widget/favourite_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import '../../../../base/controller/consumer_base.dart';
import '../../../../common/values/styles.dart';

class ListFavouriteWidget extends StatefulWidget {
  const ListFavouriteWidget({super.key});

  @override
  State<ListFavouriteWidget> createState() => _ListFavouriteWidgetState();
}

class _ListFavouriteWidgetState extends State<ListFavouriteWidget> {
  
  late FavouriteProvider favouriteProvider;
  
  @override
  void initState() {
    super.initState();
    favouriteProvider = Provider.of<FavouriteProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      favouriteProvider.getListFavourite();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width,
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.redAccent.withOpacity(0.3),
                ),
                child: Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                "Sách yêu thích",
                style: AppStyles.titleBlack,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        ConsumerBase<FavouriteProvider>(
            contextData: context,
            onRepository: (req) {
              FavouriteProvider provider = req;
              if (provider.isLoading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ProgressHUD.of(context)?.show();
                });
              }
              return const SizedBox();
            },
            onRepositoryError: (req) {
              return Center(
                  child: Text(
                    req.messagesError ?? '',
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ));
            },
            onRepositoryNoData: (req) {
              return const Center(
                child: Text(
                  'Không có dữ liệu',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              );
            },
            onRepositorySuccess: (rep) {
              FavouriteProvider provider = rep;
              if (provider.isLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ProgressHUD.of(context)?.dismiss();
                });
              }
              return buildeData(provider);
            }),
      ],
    );
  }
  Widget buildeData (FavouriteProvider provider ){
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.width *0.7,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 25),
          scrollDirection: Axis.horizontal,
          itemCount: provider.listFavourite.length,
          itemBuilder: (context, index) {
            return FavouriteItem(favourite: provider.listFavourite[index],);
          }
      ),
    );
  }
}
