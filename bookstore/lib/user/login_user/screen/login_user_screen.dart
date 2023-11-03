import 'package:bookstore/base/service/dio_option.dart';
import 'package:bookstore/user/login_user/controller/login_user_provider.dart';
import 'package:bookstore/user/login_user/screen/widget/body_login_user_widget.dart';
import 'package:bookstore/user/login_user/service/login_user_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginUserScreen extends StatefulWidget {
  const LoginUserScreen({super.key});

  @override
  State<LoginUserScreen> createState() => _LoginUserScreenState();
}

class _LoginUserScreenState extends State<LoginUserScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginUserProvider(LoginUserServices(DioOption().createDio(addToken: true))))
      ],
      child: Scaffold(
       body: SizedBox(
         width: double.infinity,
         height: double.infinity,
         child: ProgressHUD(
           child: Builder(builder: (context){
             return BodyLoginUserWidget();
           },)
         ),
       ),
      ),
    );
  }
}
