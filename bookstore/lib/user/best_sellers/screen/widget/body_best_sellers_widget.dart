import 'package:bookstore/user/best_sellers/screen/widget/search_best_sellers_widget.dart';
import 'package:bookstore/user/home/screen/widget/best_sellers_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import '../../../../base/controller/consumer_base.dart';
import '../../controller/best_sellers_provider.dart';
import 'package:provider/provider.dart';
class BodyBestSellersWidget extends StatefulWidget {
  const BodyBestSellersWidget({super.key});

  @override
  State<BodyBestSellersWidget> createState() => _BodyBestSellersWidgetState();
}

class _BodyBestSellersWidgetState extends State<BodyBestSellersWidget> {
  late BestSellersProvider bestSellersProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bestSellersProvider = Provider.of<BestSellersProvider>(context,listen: false);
    bestSellersProvider.listBestSellers = [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bestSellersProvider.getListBestSellers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
      child: Column(
        children: [
          SearchBestSellerWidget(),
          SizedBox(height: 20,),
          ConsumerBase<BestSellersProvider>(
              contextData: context,
              onRepository: (req) {
                BestSellersProvider provider = req;
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
                BestSellersProvider provider = rep;
                if (provider.isLoaded) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ProgressHUD.of(context)?.dismiss();
                  });
                }
                return buildData(provider);
              }),
        ],
      )
    );
  }
  Widget buildData (BestSellersProvider provider){
    return  Expanded(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.52,
              crossAxisCount: 2,
              crossAxisSpacing: 50,
              mainAxisSpacing: 15,
            ),
            itemCount: provider.listBestSellers.length,
            itemBuilder: (context, index) {
              return BestSellersItemt(bestSellers: provider.listBestSellers[index]);
            }
        )
    );
  }
}
