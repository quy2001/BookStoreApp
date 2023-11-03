import 'package:flutter/material.dart';

import '../../common/values/colors.dart';


class ButtonWidget extends StatelessWidget {
   ButtonWidget({super.key, required this.title, required this.ontap});
  final String title;
  final Function() ontap;


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: ontap,
      textColor: Colors.white,
      color: AppColors.primaryColor,
      height: 50,
      minWidth: double.maxFinite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}
