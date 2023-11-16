import 'package:bookstore/user/search_book/screen/widget/search_filter_widget.dart';
import 'package:flutter/material.dart';

import '../../../../common/values/colors.dart';
import '../../controller/search_book_provider.dart';
import 'package:provider/provider.dart';

class SearchNameBookWidget extends StatefulWidget {
  const SearchNameBookWidget({super.key});

  @override
  State<SearchNameBookWidget> createState() => _SearchNameBookWidgetState();
}

class _SearchNameBookWidgetState extends State<SearchNameBookWidget> {
  TextEditingController txtSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final SearchBookProvider bookSearchProvider = Provider.of<SearchBookProvider>(context,listen: false);
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
            bookSearchProvider.search(value);
          });
        },
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.subTitleColor,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => SearchFilterWidget(
                        didFilter: (fObj) {
                          // txtSearch.text = sText;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      )));
            },
            icon: const Icon(
              Icons.tune_outlined,
              color: AppColors.subTitleColor,
            ),
          ),
          hintText: "Nhập tên sách",
          labelStyle: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
