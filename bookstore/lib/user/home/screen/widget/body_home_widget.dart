import 'package:bookstore/common/values/colors.dart';
import 'package:bookstore/common/values/styles.dart';
import 'package:bookstore/user/home/screen/widget/top_picks_widget.dart';
import 'package:flutter/material.dart';
import '../../../best_sellers/screen/best_seller_screen.dart';
import '../../../main_tab/main_tab_screen.dart';
import 'best_sellers_widget.dart';

class BodyHomeWidget extends StatefulWidget {
  const BodyHomeWidget({super.key});

  @override
  State<BodyHomeWidget> createState() => _BodyHomeWidgetState();
}

class _BodyHomeWidgetState extends State<BodyHomeWidget> {
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(
                          "Bán chạy",
                          style: AppStyles.titleBlack,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>BestSellerScreen()));
                        },
                        child: const Row(
                          children: [
                            Text('Xem tất cả'),
                            Icon(
                                Icons.navigate_next_outlined
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  BestSellersWidget()
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
