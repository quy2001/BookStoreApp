import 'package:bookstore/base/service/dio_option.dart';
import 'package:bookstore/user/bookcase/controller/bookcase_provider.dart';
import 'package:bookstore/user/bookcase/screen/widget/body_bookcase_widget.dart';
import 'package:bookstore/user/bookcase/service/bookcase_service.dart';
import 'package:flutter/material.dart';

import '../../../base/widgets/app_bar_widget.dart';
import 'package:provider/provider.dart';

class BookcaseScreen extends StatefulWidget {
  const BookcaseScreen({super.key});

  @override
  State<BookcaseScreen> createState() => _BookcaseScreenState();
}

class _BookcaseScreenState extends State<BookcaseScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> BookcaseProvider(BookcaseServices(DioOption().createDio())))
      ],
      child: AppBarWidget(
        tittle: Text('Tủ sách của tôi'),
        haveMenuButton: true,
        child: BodyBookcaseWidget(),
      ),
    );
  }
}
