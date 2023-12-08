import 'package:bookstore/common/values/colors.dart';
import 'package:bookstore/user/cart/controller/cart_provider.dart';
import 'package:bookstore/user/cart/service/cart_service.dart';
import 'package:bookstore/user/search_book/controller/search_book_provider.dart';
import 'package:bookstore/user/search_book/screen/widget/body_search_book_widget.dart';
import 'package:bookstore/user/search_book/screen/widget/search_name_book_widget.dart';
import 'package:bookstore/user/search_book/service/book_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../../../base/service/dio_option.dart';
import '../../authors/controller/author_provider.dart';
import '../../categories/controller/category_provider.dart';
import '../../authors/services/author_service.dart';
import '../../categories/service/category_service.dart';

class SearchBookScreen extends StatefulWidget {
  const SearchBookScreen({super.key});

  @override
  State<SearchBookScreen> createState() => _SearchBookScreenState();
}

class _SearchBookScreenState extends State<SearchBookScreen> {
  // TextEditingController txtSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                SearchBookProvider(SearchBookServices(DioOption().createDio()))),
        ChangeNotifierProvider(
            create: (context)=>CategoryProvider(CategoryServices(DioOption().createDio()))),
        ChangeNotifierProvider(
            create: (context)=>AuthorProvider(AuthorService(DioOption().createDio()))),
        ChangeNotifierProvider(
            create: (context)=>CartProvider(CartServices(DioOption().createDio()))),
      ],
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(),
          leadingWidth: 0,
          title: SearchNameBookWidget(),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ProgressHUD(child: Builder(
            builder: (context) {
              return BodySearchBookWidget();
            },
          )),
        ),
      ),
    );
  }
}
