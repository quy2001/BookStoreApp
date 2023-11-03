import 'package:bookstore/common/values/styles.dart';
import 'package:bookstore/user/home/controller/author_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import '../../../../base/controller/base_provider.dart';

class AuthorWidget extends StatefulWidget {
  const AuthorWidget({super.key});

  @override
  State<AuthorWidget> createState() => _AuthorWidgetState();
}

class _AuthorWidgetState extends State<AuthorWidget> {
  late AuthorProvider authorProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authorProvider = Provider.of<AuthorProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authorProvider.getAuthor(context);
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
            "Tác giả",
            style: AppStyles.titleBlack,
            textAlign: TextAlign.start,
          ),
        ),
        Selector<AuthorProvider, Status>(
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
              return buildData(context,authorProvider);
            },
            selector: (context, pro) {
              return pro.statusAuthor;
            })
      ],
    );
  }
}

Widget buildData (BuildContext context,AuthorProvider provider){
  Size size = MediaQuery.of(context).size;
  return SizedBox(
    height: size.width*0.35,
    child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: provider.authorArr.length,
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
                        provider.authorArr[index].name,
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
