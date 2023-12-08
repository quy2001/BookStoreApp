import 'package:bookstore/user/book_details/screen/book_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../../../common/values/styles.dart';
import '../../../search_book/model/search_books_response.dart';

class TopPickItemWidge extends StatefulWidget {
  const TopPickItemWidge({super.key, required this.listBook});

  final SearchBook listBook;

  @override
  State<TopPickItemWidge> createState() => _TopPickItemWidgeState();
}

class _TopPickItemWidgeState extends State<TopPickItemWidge> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => BookDetailScreen(
                    id: widget.listBook.id,
                    titleBook: widget.listBook.name,
                    statusBook:
                        bool.parse(widget.listBook.status.toString()), statusFavourite: bool.parse(widget.listBook.statusFavoutite.toString()),)));
      },
      child: SizedBox(
        width: size.width * 0.32,
        child: Column(
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
                  widget.listBook.cover,
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
              widget.listBook.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: AppStyles.titleBook,
            ),
            Text(
              widget.listBook.aname,
              style: AppStyles.subTitle,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
