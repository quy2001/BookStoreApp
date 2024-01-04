import 'package:bookstore/user/book_details/screen/book_detail_screen.dart';
import 'package:bookstore/user/favourite/model/favourite_response.dart';
import 'package:flutter/material.dart';

import '../../../../common/values/styles.dart';
class FavouriteItem extends StatefulWidget {
  const FavouriteItem({super.key, required this.favourite});
  final Favourite favourite;
  @override
  State<FavouriteItem> createState() => _FavouriteItemState();
}

class _FavouriteItemState extends State<FavouriteItem> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>BookDetailScreen(id: widget.favourite.idBook, titleBook: widget.favourite.bname.toString(), statusBook: true, statusFavourite: true)));
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
                  widget.favourite.bimage,
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
              widget.favourite.bname,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyles.titleBook,
            ),

          ],
        ),
      ),
    );
  }
}
