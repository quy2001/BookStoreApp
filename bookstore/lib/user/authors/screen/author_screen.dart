import 'package:bookstore/base/widgets/app_bar_widget.dart';
import 'package:bookstore/user/authors/screen/widget/body_author_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../base/service/dio_option.dart';
import '../controller/author_provider.dart';
import '../services/author_service.dart';
class AuthorScreen extends StatefulWidget {
  const AuthorScreen({super.key});

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context)=>AuthorProvider(AuthorService(DioOption().createDio()))),
      ],
      child: AppBarWidget(
        tittle: Text('Tác giả'),
          haveBackButton: true,
          child: BodyAuthorWidget()
      ),
    );
  }
}
