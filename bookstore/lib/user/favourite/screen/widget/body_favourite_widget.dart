import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../base/controller/consumer_base.dart';
import '../../../../common/values/colors.dart';
import '../../controller/favourite_provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';
import 'favourite_item.dart';

class BodyFavouriteWidget extends StatefulWidget {
  const BodyFavouriteWidget({super.key});

  @override
  State<BodyFavouriteWidget> createState() => _BodyFavouriteWidgetState();
}

class _BodyFavouriteWidgetState extends State<BodyFavouriteWidget> {

  late FavouriteProvider favouriteProvider;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    favouriteProvider = Provider.of<FavouriteProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      favouriteProvider.getListFavourite();
    });
  }
  Future<void> _refresh() async {
    favouriteProvider.getListFavourite();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ConsumerBase<FavouriteProvider>(
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
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: Image.asset('assets/img/no_favourite.png',fit: BoxFit.contain,),
                    ),
                    Text('Không có sách yêu thích',style: TextStyle(fontSize: 20,color: AppColors.primaryColor, fontWeight: FontWeight.w600),)
                  ],
                )
            );
          },
          onRepositorySuccess: (rep) {
            FavouriteProvider provider = rep;
            if (provider.isLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ProgressHUD.of(context)?.dismiss();
              });
            }
            return buildData(provider);
          }),
    );
  }
  Widget buildData (FavouriteProvider provider){
    return  RefreshLoadmore(
      onRefresh: _refresh,
      isLastPage: true,
      child: GridView.builder(
          controller: scrollController,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.52,
            crossAxisCount: 2,
            crossAxisSpacing: 50,
            mainAxisSpacing: 15,
          ),
          itemCount: provider.listFavourite.length,
          itemBuilder: (context, index) {
            return FavouriteItem(favourite: provider.listFavourite[index],);
          }
      ),
    );
  }
}
