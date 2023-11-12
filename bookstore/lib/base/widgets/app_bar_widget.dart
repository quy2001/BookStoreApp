import 'package:bookstore/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import 'button_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {super.key,
      required this.child,
      this.tittle,
      this.haveBackButton, this.haveBottomButton, this.functionBottomButton, this.tittleButton});

  final Widget child;
  final Widget? tittle;
  final String? tittleButton;
  final bool? haveBackButton;
  final bool? haveBottomButton;
  final Function()? functionBottomButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: tittle,
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        shadowColor: AppColors.primaryColor,
        leading: haveBackButton == true
            ? BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
              )
            : const SizedBox(),
      ),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ProgressHUD(
            child: Builder(
              builder: (context) {
                return child;
              },
            ),
          )
      ),
      bottomNavigationBar: haveBottomButton == true ? BottomAppBar(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              offset: Offset(0, -3),
            ),
          ]),
          child: ButtonWidget(
              title: tittleButton!,
              ontap: functionBottomButton!),
        ),
      ) : const SizedBox(),
    );
  }
}
