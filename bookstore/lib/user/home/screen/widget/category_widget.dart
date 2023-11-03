import 'package:bookstore/common/values/styles.dart';
import 'package:bookstore/user/home/controller/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../base/controller/base_provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}


class _CategoryWidgetState extends State<CategoryWidget> {
  late CategoryProvider categoryProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryProvider = Provider.of<CategoryProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryProvider.getCategory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text(
            "Thể loại sách",
            style: AppStyles.titleBlack,
            textAlign: TextAlign.start,
          ),
        ),
        Selector<CategoryProvider, Status>(
            builder: (context, value, child) {
              if(value==Status.loading){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ProgressHUD.of(context)?.show();
                });
              }else if ( value == Status.loaded){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ProgressHUD.of(context)?.dismiss();
                });
              }else if (value == Status.error) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ProgressHUD.of(context)?.dismiss();
                });
              }
              return buildData(context,categoryProvider);
            },
            selector: (context, pro) {
              return pro.statusCategory;
            })
      ],
    );
  }
}

Widget buildData (BuildContext context,CategoryProvider provider){
  Size size = MediaQuery.of(context).size;
  return SizedBox(
    height: size.width*0.3,
    child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: provider.categoryArr.length,
        itemBuilder: (context, index) {
          // var cObj = categoryProvider.categoryArr[index] as Map? ?? {};
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: size.width * 0.32,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 4),
                          blurRadius: 5,
                        )
                      ]),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        provider.categoryArr[index].name,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: AppStyles.titleBook,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
  );
}