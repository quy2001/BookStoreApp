import 'package:bookstore/user/cart/controller/cart_provider.dart';
import 'package:bookstore/user/cart/screen/widget/body_cart_widget.dart';
import 'package:bookstore/user/cart/service/cart_service.dart';
import 'package:flutter/material.dart';

import '../../../base/service/dio_option.dart';
import '../../../base/widgets/app_bar_widget.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CarttScreenState();
}

class _CarttScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context)=>CartProvider(CartServices(DioOption().createDio())),
        ),
      ],
      child: AppBarWidget(
        tittle: Text('Giỏ hàng'),
        haveMenuButton: true,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BodyCartWidget(),
        ),
      ),
    );
  }
}
