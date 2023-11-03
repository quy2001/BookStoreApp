import 'package:bookstore/base/service/dio_option.dart';
import 'package:bookstore/user/register/controller/register_provider.dart';
import 'package:bookstore/user/register/screen/widget/body_register_widget.dart';
import 'package:bookstore/user/register/service/register_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/values/colors.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:dio/dio.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                RegisterProvider(RegisterServices(DioOption().createDio())))
      ],
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'Đăng ký',
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: ProgressHUD(child: Builder(builder: (context){
          return BodyRegisterWidget();
        }
        )),
      ),
    );
  }
}
