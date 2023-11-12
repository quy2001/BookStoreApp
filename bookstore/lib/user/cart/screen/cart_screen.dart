import 'package:flutter/material.dart';

import '../../../base/widgets/app_bar_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CarttScreenState();
}

class _CarttScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      tittle: Text('Giỏ hàng'),
      child: Container(),
    );
  }
}
