import 'package:bookstore/base/widgets/app_bar_widget.dart';
import 'package:bookstore/user/favourite/screen/widget/body_favourite_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../base/service/dio_option.dart';
import '../controller/favourite_provider.dart';
import '../service/favourite_service.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> FavouriteProvider(FavouriteServices(DioOption().createDio())))
      ],
      child: AppBarWidget(
        // haveBackButton: true,
        haveMenuButton: true,
          tittle: Text('Sách yêu thích'),
          child: BodyFavouriteWidget()),
    );
  }
}
