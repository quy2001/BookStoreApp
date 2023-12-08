import 'package:bookstore/user/account/controller/account_provider.dart';
import 'package:bookstore/user/account/screen/widget/body_account_widget.dart';
import 'package:bookstore/user/account/service/account_service.dart';
import 'package:bookstore/user/favourite/controller/favourite_provider.dart';
import 'package:bookstore/user/favourite/service/favourite_service.dart';
import 'package:flutter/material.dart';

import '../../../base/service/dio_option.dart';
import '../../../base/widgets/app_bar_widget.dart';
import 'package:provider/provider.dart';
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> AccountProvider(AccountService(DioOption().createDio()))),
        ChangeNotifierProvider(create: (context)=> FavouriteProvider(FavouriteServices(DioOption().createDio())))
      ],
      child: AppBarWidget(
        haveMenuButton: true,
        tittle: Text('Tài khoản'),
        child: BodyAccountWidget(),
      ),
    );
  }
}
