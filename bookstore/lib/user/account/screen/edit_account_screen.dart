import 'package:bookstore/base/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
        tittle: Text('Chỉnh sửa tài khoản'),
        haveBackButton: true,
        child: Container());
  }
}
