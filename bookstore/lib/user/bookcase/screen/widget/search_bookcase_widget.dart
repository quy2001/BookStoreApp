import 'package:flutter/material.dart';

import '../../../../common/values/colors.dart';

class SearchBookcaseWidget extends StatelessWidget {
  SearchBookcaseWidget({super.key});
  TextEditingController txtSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textbox,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.subTitle, width: 1),
      ),
      child: TextField(
        controller: txtSearch,
        decoration: const InputDecoration(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.subTitleColor,
          ),
          hintText: "Nhập tên sách",
          labelStyle: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
