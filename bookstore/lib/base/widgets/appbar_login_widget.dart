import 'package:bookstore/common/values/assets.dart';
import 'package:flutter/material.dart';

class AppBarLoginWidget extends StatelessWidget {
  AppBarLoginWidget({super.key,required this.title});

  String title;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      Image.asset(
       AppAssets.imgLoginBg,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
      Container(
        width: size.width,
        padding: EdgeInsets.only(top: size.height*0.26),
        child:  Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),),
      )
    ]);
  }
}
