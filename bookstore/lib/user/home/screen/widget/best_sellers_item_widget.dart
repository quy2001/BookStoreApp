import 'package:bookstore/user/best_sellers/model/best_sellers_response.dart';
import 'package:bookstore/user/book_details/screen/book_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../../../common/values/styles.dart';

class BestSellersItemt extends StatefulWidget {
  const BestSellersItemt({super.key, required this.bestSellers});

  final BestSellers bestSellers;

  @override
  State<BestSellersItemt> createState() => _BestSellersItemtState();
}

class _BestSellersItemtState extends State<BestSellersItemt> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => BookDetailScreen(
                    id: widget.bestSellers.idBook,
                    titleBook: widget.bestSellers.bname,
                    statusBook: bool.parse(widget.bestSellers.status),
                    statusFavourite:
                        bool.parse(widget.bestSellers.statusFavourite))));
      },
      child: Container(
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
                child: Image.network(
                  widget.bestSellers.bimage,
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
              widget.bestSellers.bname,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyles.titleBook,
            ),
            const SizedBox(
              height: 8,
            ),
            bool.parse(widget.bestSellers.status) == true ? Text(
                    'Đã mua',
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w600),
                  ) : RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: widget.bestSellers.bprice.toString(),
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          ),
                          const TextSpan(
                            text: ".000",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          ),
                          const TextSpan(
                            text: " VNĐ",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w600),
                          ),
                        ]),
                  ),
            const SizedBox(
              height: 8,
            ),
            RichText(
              text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    const TextSpan(
                      text: "Lượt mua: ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: widget.bestSellers.tongBan.toString(),
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
