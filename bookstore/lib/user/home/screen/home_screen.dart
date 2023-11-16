import 'package:bookstore/base/service/dio_option.dart';
import 'package:bookstore/common/values/colors.dart';
import 'package:bookstore/user/home/controller/top_picks_provider.dart';
import 'package:bookstore/user/home/screen/widget/body_home_widget.dart';
import 'package:bookstore/user/home/service/top_picks_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context)=>TopPickProvider(TopPickServices(DioOption().createDio()))),
      ],
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: ProgressHUD(
          child: Builder(
            builder: (context){
              return BodyHomeWidget();
            },
          ),
        )
      ),
    );
  }
}
