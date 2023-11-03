import 'package:bookstore/user/login_user/screen/login_user_screen.dart';
import 'package:flutter/material.dart';

import '../../base/widgets/button_widget.dart';
import '../../common/values/colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/img/welcome_bg.png",
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(height: size.width*0.25,),
                  const Text(
                    "Books For\nEvery Taste",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: size.width*0.25,),
                  ButtonWidget(
                    title: 'Người mua sách',
                    ontap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginUserScreen()));
                    },
                  ),
                  SizedBox(height: size.width*0.1,),
                  ButtonWidget(
                  title: 'Quản trị viên',
                  ontap: (){},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
