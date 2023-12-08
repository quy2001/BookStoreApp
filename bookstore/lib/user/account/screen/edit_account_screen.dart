import 'package:bookstore/base/widgets/app_bar_widget.dart';
import 'package:bookstore/user/account/screen/widget/body_edit_account_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../base/service/dio_option.dart';
import '../controller/account_provider.dart';
import '../service/account_service.dart';

class EditAccountScreen extends StatefulWidget {
   EditAccountScreen({super.key, required this.name, required this.email});
  String name;
  String email;

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> AccountProvider(AccountService(DioOption().createDio()))),
      ],
      child: AppBarWidget(
          tittle: Text('Chỉnh sửa tài khoản'),
          haveBackButton: true,
          child: BodyEditAccountWidget(name: widget.name, email: widget.email,)
      ),
    );
  }
}
