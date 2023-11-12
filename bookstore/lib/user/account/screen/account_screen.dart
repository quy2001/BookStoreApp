import 'package:flutter/material.dart';

import '../../../base/widgets/app_bar_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      tittle: Text('Tài khoản'),
      child: Container(),
    );
  }
}
