import 'package:bookstore/user/bookcase/model/bookcaseResponse.dart';
import 'package:flutter/material.dart';

import '../../../../common/values/colors.dart';
class BookCaseItemWidget extends StatefulWidget {
  BookCaseItemWidget({super.key, required this.index, required this.bookcase});
  final Bookcase bookcase;
  final int index;
  @override
  State<BookCaseItemWidget> createState() => _BookCaseItemWidgetState();
}

class _BookCaseItemWidgetState extends State<BookCaseItemWidget> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.searchBGColor[widget.index % AppColors.searchBGColor.length],
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
      child: Column(
        children: [
          Text(widget.bookcase.bname,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(widget.bookcase.bimage,
              width: size.width*0.23,
              height: size.width*0.25*1.45,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
