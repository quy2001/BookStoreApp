import 'package:bookstore/user/best_sellers/controller/best_sellers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../../../base/controller/consumer_base.dart';
import 'best_sellers_item_widget.dart';

class BestSellersWidget extends StatefulWidget {
  const BestSellersWidget({super.key});

  @override
  State<BestSellersWidget> createState() => _BestSellersWidgetState();
}

class _BestSellersWidgetState extends State<BestSellersWidget> {

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
    return  Center(
      child:  ConsumerBase<BestSellersProvider>(
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
            return buildData(context,provider);
          }),
    );
  }

  Widget buildData (BuildContext context,BestSellersProvider provider ){
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.width,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 8),
          scrollDirection: Axis.horizontal,
          itemCount: provider.listBestSellers.length,
          itemBuilder: (context, index) {
            return BestSellersItemt(bestSellers: provider.listBestSellers[index],);
          }
      ),
    );
  }
}
