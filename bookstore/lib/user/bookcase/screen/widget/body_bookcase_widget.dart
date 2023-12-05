import 'package:bookstore/user/bookcase/screen/widget/bookcase_item_widget.dart';
import 'package:bookstore/user/bookcase/screen/widget/search_bookcase_widget.dart';
import 'package:flutter/material.dart';
class BodyBookcaseWidget extends StatefulWidget {
  const BodyBookcaseWidget({super.key});

  @override
  State<BodyBookcaseWidget> createState() => _BodyBookcaseWidgetState();
}

class _BodyBookcaseWidgetState extends State<BodyBookcaseWidget> {
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
    {
      "name": "Tôi là bê tô",
      "img": "assets/img/toi_la_be_to.jpg",
    },
    {
      "name": "Business",
      "img": "assets/img/2.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
      child: Column(
        children: [
          SearchBookcaseWidget(),
          SizedBox(height: 20,),

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
                  return BookCaseItemWidget(
                    sObj: sObj,
                    index: index,
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}

