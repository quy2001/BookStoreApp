import 'package:flutter/material.dart';

import '../../../../common/values/colors.dart';
class SearchGridWidget extends StatefulWidget {
  SearchGridWidget({super.key, required this.sObj, required this.index});
  final Map sObj;
  final int index;
  @override
  State<SearchGridWidget> createState() => _SearchGridWidgetState();
}

class _SearchGridWidgetState extends State<SearchGridWidget> {

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
          Text(widget.sObj["name"].toString(),
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
            child: Image.asset(widget.sObj["img"].toString(),
              width: size.width*0.25,
              height: size.width*0.25*1.6,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
