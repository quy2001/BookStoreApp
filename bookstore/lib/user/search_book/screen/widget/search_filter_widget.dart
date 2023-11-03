import 'package:bookstore/base/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import '../../../../common/values/colors.dart';

class SearchFilterWidget extends StatefulWidget {
  const SearchFilterWidget({super.key, this.didFilter});
  final Function(Map)? didFilter;

  @override
  State<SearchFilterWidget> createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  TextEditingController txtSearch = TextEditingController();
  int selectSort = 0;
  List sortByArr = [
    "Giá từ thấp-cao",
    "Giá từ cao-thấp",
    "Tên sách từ A-Z",
    "Tên sách từ Z-A",
    "Lượt mua nhiều-ít",
    "Lượt đánh giá cao-thấp"
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
                child: Text(
              'Bộ lọc',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
            )),
            const SizedBox(
              width: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
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
                    ),
                  )),
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 17),
              child: Text(
                'Tìm kiếm theo',
                style: TextStyle(
                  color: AppColors.subTitleColor,
                  fontSize: 17,
                ),
              ),
            ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: sortByArr.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var itemName = sortByArr[index] as String? ?? "";
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectSort = index;
                  });
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      Icon(
                          selectSort == index
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: selectSort == index
                              ? AppColors.primaryColor
                              : AppColors.subTitle),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            itemName,
                            style: TextStyle(color: AppColors.titleColor, fontSize: 15),
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
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
              title: "Tìm kiếm",
              ontap: () {
                Navigator.pop(context);
              }),
        ),
      ),
    );
  }
}
