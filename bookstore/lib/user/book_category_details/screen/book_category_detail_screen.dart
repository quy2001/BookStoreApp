import 'package:bookstore/base/widgets/app_bar_widget.dart';
import 'package:bookstore/user/book_category_details/screen/widget/body_book_category_widget.dart';
import 'package:bookstore/user/book_category_details/service/book_category_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../base/service/dio_option.dart';
import '../../cart/controller/cart_provider.dart';
import '../../cart/service/cart_service.dart';
import '../../search_book/controller/search_book_provider.dart';
import '../../search_book/service/book_service.dart';
import '../controller/book_category_provider.dart';
class BookCategoryDetailScreen extends StatefulWidget {
  const BookCategoryDetailScreen({super.key, required this.titleCategory, required this.id});
 final String titleCategory;
 final int id;
  @override
  State<BookCategoryDetailScreen> createState() => _BookCategoryDetailScreenState();
}

class _BookCategoryDetailScreenState extends State<BookCategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context)=>CartProvider(CartServices(DioOption().createDio()))),
        ChangeNotifierProvider(
            create: (context) =>
                SearchBookProvider(SearchBookServices(DioOption().createDio()))),
      ],
      child: AppBarWidget(
        tittle: Text(widget.titleCategory),
          haveBackButton: true,
          child: BodyBookCategoryWidget(id: widget.id,)),
    );
  }
}
