import 'package:bookstore/base/widgets/app_bar_widget.dart';
import 'package:bookstore/user/categories/screen/widget/body_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../base/service/dio_option.dart';
import '../controller/category_provider.dart';
import '../service/category_service.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>CategoryProvider(CategoryServices(DioOption().createDio()))),
      ],
      child: AppBarWidget(
        tittle: Text('Thể loại'),
          haveMenuButton: true,
          child: BodyCategoryWidget()),
    );
  }
}
