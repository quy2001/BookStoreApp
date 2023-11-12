import 'package:flutter/material.dart';

import '../../../../common/values/colors.dart';

class FilterAuthCate extends StatefulWidget {
  const FilterAuthCate({super.key});

  @override
  State<FilterAuthCate> createState() => _FilterAuthCateState();
}

class _FilterAuthCateState extends State<FilterAuthCate> {



  _FilterAuthCateState(){
    valueAuthor = tagsArr[0];
  }

  String? valueAuthor = '';
  List tagsArr = [
    '',
    "Mèo Xù",
    "Nguyễn Nhật Ánh",
    "Hector Malot",
    "Tố Hữu	",
    "Nguyễn Lân	",
    "Kim Dung	"
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Padding(
      padding: const EdgeInsets.only(left: 15,top:8,bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: size.width * 0.4,
            height: size.width * 0.08,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.subTitle, width: 1),
            ),
            child: Center(
              child: DropdownButton(
                underline: Container(),
                isExpanded: true,
                value: valueAuthor,
                items: tagsArr.map((tag) {
                  String displayText = tag.length > 12 ? tag.substring(0, 12) + "..." : tag;
                  return DropdownMenuItem(
                    value: tag,
                    child: Text(displayText),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    valueAuthor = value as String;
                  });
                },
              ),
            ),
          ),
          SizedBox(width: size.width*0.02,),
          Container(
            width: size.width * 0.4,
            height: size.width * 0.08,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.subTitle, width: 1),
            ),
            child: Center(
              child: DropdownButton(
                underline: Container(),
                isExpanded: true,
                value: valueAuthor,
                items: tagsArr.map((tag) {
                  String displayText = tag.length > 12 ? tag.substring(0, 12) + "..." : tag;
                  return DropdownMenuItem(
                    value: tag,
                    child: Text(displayText),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    valueAuthor = value as String;
                  });
                },
              ),
            ),
          ),
          IconButton(onPressed: (){},
              icon: Icon(Icons.filter_alt_outlined))
        ],
      ),
    );
  }
}
