import 'package:bookstore/user/search_book/screen/search_book_screen.dart';
import 'package:flutter/material.dart';

import '../../../../common/values/colors.dart';

class SearchForceWidget extends StatefulWidget {
   SearchForceWidget({super.key,required this.didSearch});
   final Function(String)? didSearch;
  @override
  State<SearchForceWidget> createState() => _SearchForceWidgetState();
}

class _SearchForceWidgetState extends State<SearchForceWidget> {
  TextEditingController txtSearch = TextEditingController();
  List perviousArr = [
    "Search 1",
    "Search 2",
    "Search 3",
    "Search 4",
    "Search 5"
  ];
  List resultArr = [
    "Gross Anatomy",
    "When To Rob A Bank",
    "The Bite In The Apple",
    "The Ignorant Maestro"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(),
        leadingWidth: 0,
        title: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.textbox,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.subTitle,width: 1),
                ),
                child: TextField(
                  controller: txtSearch,
                  onChanged: (value){
                      setState(() {

                      });
                  },
                  decoration:  const InputDecoration(
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
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (c)=> SearchBookScreen()));
                  },
                  child: const Text(
                    'Hủy',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  )),
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(txtSearch.text.isEmpty)//nếu có nhập gì
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 17),
            child: Text(
              'Các tìm kiếm gần đây',
              style: TextStyle(
                color: AppColors.subTitleColor,
                fontSize: 17,
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                  itemCount: txtSearch.text.isEmpty ? perviousArr.length : resultArr.length,
                  itemBuilder: (context, index) {
                    var searchResultText = ( txtSearch.text.isEmpty ? perviousArr : resultArr )[index] as  String? ?? "";
                    return GestureDetector(
                      onTap: (){
                        if(widget.didSearch != null){
                          widget.didSearch!(searchResultText);
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: AppColors.subTitle,
                              ),
                              const SizedBox(width: 20,),
                              Expanded(
                                  child: Text(
                                searchResultText,
                                style: const TextStyle(
                                  color: AppColors.titleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              )),
                              Text(
                                'Xóa',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
