import 'package:bookstore/base/widgets/app_bar_widget.dart';
import 'package:bookstore/user/book_details/controller/book_provider.dart';
import 'package:bookstore/user/book_details/screen/widget/body_book_detail_widget.dart';
import 'package:bookstore/user/book_details/service/book_service.dart';
import 'package:bookstore/user/favourite/controller/favourite_provider.dart';
import 'package:bookstore/user/favourite/service/favourite_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../base/service/dio_option.dart';
import '../../cart/controller/cart_provider.dart';
import '../../cart/service/cart_service.dart';

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({super.key, required this.id, required this.titleBook, required this.statusBook, required this.statusFavourite});
 final int id;
 final String titleBook;
 final bool statusBook;
  final bool statusFavourite;
  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> BookProvider(BookService(DioOption().createDio()))),
        ChangeNotifierProvider(
            create: (context)=>CartProvider(CartServices(DioOption().createDio()))),
        ChangeNotifierProvider(
            create: (context)=>FavouriteProvider(FavouriteServices(DioOption().createDio()))),

      ],
      child: AppBarWidget(
        haveBottomButton:widget.statusBook == true ? true : false,
        tittleButton: 'Sách nói' ,
        functionBottomButton: (){

        },
        tittle: Text(widget.titleBook),
          haveBackButton: true,
          child: BodyBookDetailWidget(id: widget.id, statusBook: widget.statusBook, statusFavourite: widget.statusFavourite,)
      ),
    );
  }
}
