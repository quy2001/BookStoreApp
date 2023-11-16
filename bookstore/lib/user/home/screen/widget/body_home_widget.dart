import 'package:bookstore/common/values/colors.dart';
import 'package:bookstore/common/values/styles.dart';
import 'package:bookstore/user/home/screen/widget/top_picks_widget.dart';
import 'package:flutter/material.dart';
import '../../../main_tab/main_tab_screen.dart';
import 'best_seller_widget.dart';

class BodyHomeWidget extends StatefulWidget {
  const BodyHomeWidget({super.key});

  @override
  State<BodyHomeWidget> createState() => _BodyHomeWidgetState();
}

class _BodyHomeWidgetState extends State<BodyHomeWidget> {

  List bestSellerArr = [
    {
      "name": "The Dissapearance of Emila Zola",
      "author": "Michael Rosen",
      "img": "assets/img/1.jpg",
      "rating": 5.0
    },
    {
      "name": "Fatherhood",
      "author": "Marcus Berkmann ",
      "img": "assets/img/2.jpg",
      "rating": 4.0
    },
    {
      "name": "The Time Travellers Handbook",
      "author": "Stride Lottie",
      "img": "assets/img/3.jpg",
      "rating": 3.0
    },
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                child: Transform.scale(
                  scale: 1.5,
                  origin: Offset(0, size.width * 0.85),
                  child: Container(
                    width: size.width,
                    height: size.width,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(size.width),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title:  Text(
                      'Sách mới nhất',
                      style: AppStyles.titleWhite,
                    ),
                    leading: Container(),
                    leadingWidth: 1,
                    actions: [
                      IconButton(onPressed: () {
                        sideMenuScaffoldKey.currentState?.openEndDrawer();
                      }, icon: Icon(Icons.menu))
                    ],
                  ),
                  const TopPicksWidget(),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      "Bán chạy",
                      style: AppStyles.titleBlack,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: size.width,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 8),
                      scrollDirection: Axis.horizontal,
                        itemCount: bestSellerArr.length,
                        itemBuilder: (context, index) {
                          var bObj = bestSellerArr[index] as Map? ?? {};
                          return BestSellerWidget(bObj:bObj);
                        }),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
