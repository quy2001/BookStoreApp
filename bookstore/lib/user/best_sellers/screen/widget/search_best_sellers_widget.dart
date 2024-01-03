import 'package:bookstore/user/best_sellers/controller/best_sellers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../common/values/colors.dart';

class SearchBestSellerWidget extends StatefulWidget {
  const SearchBestSellerWidget({super.key});

  @override
  State<SearchBestSellerWidget> createState() => _SearchBestSellerWidgetState();
}
class _SearchBestSellerWidgetState extends State<SearchBestSellerWidget> {
  TextEditingController txtSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final BestSellersProvider bestSellersProvider = Provider.of<BestSellersProvider>(context,listen: false);
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
            bestSellersProvider.searchBestSellers(value);
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
