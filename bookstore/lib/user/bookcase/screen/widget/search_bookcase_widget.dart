import 'package:bookstore/user/bookcase/controller/bookcase_provider.dart';
import 'package:flutter/material.dart';

import '../../../../common/values/colors.dart';
import 'package:provider/provider.dart';


class SearchBookcaseWidget extends StatefulWidget {
  const SearchBookcaseWidget({super.key});

  @override
  State<SearchBookcaseWidget> createState() => _SearchBookcaseWidgetState();
}

class _SearchBookcaseWidgetState extends State<SearchBookcaseWidget> {
  TextEditingController txtSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final BookcaseProvider bookcaseProvider = Provider.of<BookcaseProvider>(context,listen: false);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textbox,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.subTitle, width: 1),
      ),
      child: TextField(
        controller: txtSearch,
        onChanged: (value){
          setState(() {
            bookcaseProvider.searchMyBook(value);
          });
        },
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

