import 'package:bookstore/user/book_author_details/screen/widget/body_book_author_widget.dart';
import 'package:flutter/material.dart';

import '../../../base/service/dio_option.dart';
import '../../../base/widgets/app_bar_widget.dart';
import 'package:provider/provider.dart';

import '../../bookcase/controller/bookcase_provider.dart';
import '../../bookcase/service/bookcase_service.dart';
import '../../cart/controller/cart_provider.dart';
import '../../cart/service/cart_service.dart';
import '../controller/book_author_provider.dart';
import '../service/book_author_service.dart';

class BookAuthorDetailScreen extends StatefulWidget {
  const BookAuthorDetailScreen({super.key, required this.titleAuthor, required this.id});
  final String titleAuthor;
  final int id;
  @override
  State<BookAuthorDetailScreen> createState() => _BookAuthorDetailScreenState();
}

class _BookAuthorDetailScreenState extends State<BookAuthorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                BookAuthorProvider(BookAuthorServices(DioOption().createDio()))),
        ChangeNotifierProvider(
            create: (context)=>CartProvider(CartServices(DioOption().createDio()))),
        ChangeNotifierProvider(
            create: (context)=>BookcaseProvider(BookcaseServices(DioOption().createDio()))),
      ],
      child: AppBarWidget(
          tittle: Text(widget.titleAuthor),
          haveBackButton: true,
          child: BodyBookAuthorWidget(id: widget.id,)),
    );
  }
}


