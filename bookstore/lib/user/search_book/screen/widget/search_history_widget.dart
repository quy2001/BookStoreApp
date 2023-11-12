import 'package:bookstore/common/values/colors.dart';
import 'package:flutter/material.dart';
import '../../../../common/values/styles.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../book_details/screen/book_detail_screen.dart';
import '../../model/search_books_response.dart';

class SearchHistoryWidget extends StatefulWidget {
  const SearchHistoryWidget({super.key, required this.listBook});
  final SearchBook listBook;

  // final Map srObj;
  @override
  State<SearchHistoryWidget> createState() => _SearchHistoryWidgetState();
}

class _SearchHistoryWidgetState extends State<SearchHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin:const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            )
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              widget.listBook.cover.toString(),
              width: size.width * 0.33,
              height: size.width * 0.28 * 1.8,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.listBook.name.toString(),
                maxLines: 3,
                textAlign: TextAlign.left,
                style: AppStyles.titleBook,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.listBook.aname.toString(),
                style: AppStyles.subTitle,
                maxLines: 1,
              ),
              const SizedBox(
                height: 8,
              ),
              // IgnorePointer(
              //   ignoring: true,
              //   child: RatingBar.builder(
              //     initialRating:
              //         double.tryParse(widget.srObj["rate"].toString()) ?? 1,
              //     minRating: 1,
              //     direction: Axis.horizontal,
              //     allowHalfRating: true,
              //     itemCount: 5,
              //     itemSize: 15,
              //     itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              //     itemBuilder: (context, _) => const Icon(
              //       Icons.star,
              //       color: Colors.amber,
              //     ),
              //     onRatingUpdate: (rating) {},
              //   ),
              // ),
              const SizedBox(
                height: 8,
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: widget.listBook.price.toString(),
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                      const TextSpan(
                      text: " VNĐ",
                      style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600
                      ),
                      ),
                  ]
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.listBook.description.toString(),
                style: AppStyles.description,
                maxLines: 3,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(child: Container(
                    height: 35.0,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: const  [
                      BoxShadow(color: Colors.black38, blurRadius: 2, offset:  Offset(0, 2),)
                    ] ),
                    child: ElevatedButton(
                      onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (c)=> BookDetailScreen(id: widget.listBook.id,)));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: AppColors.subTitle,
                          shadowColor: Colors.transparent),
                      child:  const Text('Xem sách', style: TextStyle( color: AppColors.titleColor ,fontSize: 12) ,),
                    ),
                  )),
                  const SizedBox(width: 8,),
                  Expanded(
                    child: Container(
                      height: 35.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors:  AppColors.button),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.primaryColor,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: const Text(
                          'Thêm vào giỏ hàng',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
