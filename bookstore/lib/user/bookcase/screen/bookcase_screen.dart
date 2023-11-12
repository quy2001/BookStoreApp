import 'package:bookstore/user/bookcase/screen/widget/body_bookcase_widget.dart';
import 'package:flutter/material.dart';

import '../../../base/widgets/app_bar_widget.dart';

class BookcaseScreen extends StatefulWidget {
  const BookcaseScreen({super.key});

  @override
  State<BookcaseScreen> createState() => _BookcaseScreenState();
}

class _BookcaseScreenState extends State<BookcaseScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      tittle: Text('Tủ sách của tôi'),
      child: BodyBookcaseWidget(),
    );
  }
}
