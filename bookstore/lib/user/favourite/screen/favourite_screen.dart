import 'package:bookstore/base/widgets/app_bar_widget.dart';
import 'package:bookstore/user/favourite/screen/widget/body_favourite_widget.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      // haveBackButton: true,
      haveMenuButton: true,
        tittle: Text('Sách yêu thích'),
        child: BodyFavouriteWidget());
  }
}
