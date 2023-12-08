import 'package:bookstore/base/controller/consumer_base.dart';
import 'package:bookstore/user/home/controller/top_picks_provider.dart';
import 'package:bookstore/user/home/screen/widget/top_pick_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class TopPicksWidget extends StatefulWidget {
  const TopPicksWidget({Key? key}) : super(key: key);

  @override
  State<TopPicksWidget> createState() => _TopPicksWidgetState();
}

class _TopPicksWidgetState extends State<TopPicksWidget> {
  late TopPickProvider topPickProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topPickProvider = Provider.of<TopPickProvider>(context, listen: false);
    topPickProvider.listBookDisplay = [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      topPickProvider.getTopPick(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
     child: Padding(
       padding: const EdgeInsets.only(top:25),
       child: ConsumerBase<TopPickProvider>(
            contextData: context,
            onRepository: (req) {
              TopPickProvider provider = req;
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
              TopPickProvider provider = rep;
              if (provider.isLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ProgressHUD.of(context)?.dismiss();
                });
              }
              return buildListTop(context,provider);
            }),
     ),
    );
  }
  Widget buildListTop (BuildContext context,TopPickProvider topPickProvider){
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.width * 0.7,
      child: CarouselSlider.builder(
        itemCount: topPickProvider.listBookDisplay.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return TopPickItemWidge(listBook: topPickProvider.listBookDisplay[itemIndex],);
        },
        options: CarouselOptions(
          autoPlay: false,
          // autoPlayInterval: const Duration(seconds: 3),
          aspectRatio: 1,
          enlargeCenterPage: true,
          viewportFraction: 0.45,
          enlargeFactor: 0.4,
          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        ),
      ),
    );
  }
}
