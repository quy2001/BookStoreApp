import 'package:bookstore/common/values/colors.dart';
import 'package:bookstore/user/search_book/screen/widget/search_filter_widget.dart';
import 'package:bookstore/user/search_book/screen/widget/search_force_widget.dart';
import 'package:bookstore/user/search_book/screen/widget/search_grid_widget.dart';
import 'package:bookstore/user/search_book/screen/widget/search_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:bookstore/common/extenstion.dart';

class SearchBookScreen extends StatefulWidget {
  const SearchBookScreen({super.key});

  @override
  State<SearchBookScreen> createState() => _SearchBookScreenState();
}

class _SearchBookScreenState extends State<SearchBookScreen> {
  TextEditingController txtSearch = TextEditingController();
  int selectTag = 0;
  List tagsArr = [
    "Genre",
    "New Release",
    "The Art",
    "Genre1",
    "New Release1",
    "The Art1"
  ];

  List searchArr = [
    {
      "name": "Biography dsfdsf afdaf afasdfa fadf ",
      "img": "assets/img/1.jpg",
    },
    {
      "name": "Tôi là bê tô",
      "img": "assets/img/toi_la_be_to.jpg",
    },
    {
      "name": "Children",
      "img": "assets/img/3.jpg",
    },
    {
      "name": "Bơ đi mà sống",
      "img": "assets/img/bo_di_ma_song.jpg",
    },
    {
      "name": "Business",
      "img": "assets/img/2.jpg",
    },
  ];

  List sResultArr = [
    {
      "name": "The Heart of Hell",
      "img": "assets/img/bo_di_ma_song.jpg",
      "author": "Mitch Weiss",
      "description":
      "The untold story of courage and sacrifice in the shadow of Iwo Jima.",
      "rate": 5.0
    },
    {
      "name": "Adrennes 1944",
      "img": "assets/img/toi_la_be_to.jpg",
      "author": "Antony Beevor",
      "description":
      "#1 international bestseller and award winning history book.",
      "rate": 4.0
    },
    {
      "name": "War on the Gothic Line",
      "img": "assets/img/3.jpg",
      "author": "Christian Jennings",
      "description":
      "Through the eyes of thirteen men and women from seven different nations",
      "rate": 3.0
    },
    {
      "name": "The Heart of Hell",
      "img": "assets/img/bo_di_ma_song.jpg",
      "author": "Mitch Weiss",
      "description":
      "The untold story of courage and sacrifice in the shadow of Iwo Jima.",
      "rate": 5.0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            color: AppColors.textbox,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.subTitle, width: 1),
          ),
          child: TextField(
            controller: txtSearch,
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchForceWidget(didSearch: (sText){
                        txtSearch.text = sText;
                        if(mounted){
                          setState(() {
                          });
                        }
                      },),),);
              endEditing();
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
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> SearchFilterWidget(
                    didFilter: (fObj){
                      // txtSearch.text = sText;
                      if(mounted){
                        setState(() {

                        });
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
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: tagsArr.map((tagName) {
                    var index = tagsArr.indexOf(tagName);
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectTag = index;
                          });
                        },
                        child: Text(
                          tagName,
                          style: TextStyle(
                              fontSize: 20,
                              color: selectTag == index
                                  ? AppColors.titleColor
                                  : AppColors.subTitle,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    );
                  }).toList()),
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          if(txtSearch.text.isEmpty)
          Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.75,
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: searchArr.length,
                  itemBuilder: (context, index) {
                    var sObj = searchArr[index] as Map? ?? {};
                    return SearchGridWidget(
                      sObj: sObj,
                      index: index,
                    );
                  }
                  ),
          ),

          if(txtSearch.text.isNotEmpty)
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: sResultArr.length,
                itemBuilder: (context,index){
                var srObj = sResultArr[index] as Map? ?? {};
                  return SearchHistoryWidget(srObj: srObj,);
                }
            ),
          )
        ],
      ),
    );
  }
}
