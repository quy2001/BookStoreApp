import 'package:bookstore/common/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BestSellerWidget extends StatelessWidget {
  BestSellerWidget({super.key, required this.bObj});
  final Map bObj;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: size.width * 0.32,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0, 4),
                    blurRadius: 5,
                  )
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                bObj["img"].toString(),
                width: size.width * 0.32,
                height: size.width * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            bObj["name"].toString(),
            maxLines: 3,
            textAlign: TextAlign.left,
            style: AppStyles.titleBook,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            bObj["author"].toString(),
            style: AppStyles.subTitle,
            maxLines: 1,
          ),
          const SizedBox(
            height: 8,
          ),
          IgnorePointer(
            ignoring: true,
            child: RatingBar.builder(
              initialRating: double.tryParse( bObj["rating"].toString())?? 1 ,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 15,
              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
          )
        ],
      ),
    );
  }
}
