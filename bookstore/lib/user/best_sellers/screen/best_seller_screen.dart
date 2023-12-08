import 'package:bookstore/base/widgets/app_bar_widget.dart';
import 'package:bookstore/user/best_sellers/controller/best_sellers_provider.dart';
import 'package:bookstore/user/best_sellers/screen/widget/body_best_sellers_widget.dart';
import 'package:bookstore/user/best_sellers/service/best_sellers_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../base/service/dio_option.dart';


class BestSellerScreen extends StatefulWidget {
  const BestSellerScreen({super.key});

  @override
  State<BestSellerScreen> createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => BestSellersProvider(
                BestSellersServices(DioOption().createDio()))),
      ],
      child: AppBarWidget(
        tittle: Text('Sách bán chạy'),
          haveBackButton: true,
          child: BodyBestSellersWidget()),
    );
  }
}

