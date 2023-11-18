import 'package:bookstore/base/widgets/button_widget.dart';
import 'package:bookstore/user/cart/screen/widget/cart_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../base/widgets/app_bar_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CarttScreenState();
}

class _CarttScreenState extends State<CartScreen> {

  List cartArr = [
    {
      "name": "The Dissapearance of Emila Zola",
      "author": "Michael Rosen",
      "category": "Kiếm hiệp",
      "img": "assets/img/1.jpg",
      "price":"50000",
    },
    {
      "name": "Fatherhood",
      "author": "Marcus Berkmann ",
      "category": "Kiếm hiệp",
      "img": "assets/img/2.jpg",
      "price":"50000",
    },
    {
      "name": "The Time Travellers Handbook",
      "author": "Stride Lottie",
      "category": "Kiếm hiệp",
      "img": "assets/img/3.jpg",
      "price":"50000",
    },
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBarWidget(
      tittle: Text('Giỏ hàng'),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8),
              height: size.width*0.2,
              width: size.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                    )
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: Colors.red,
                          width: size.width*0.25,
                          child: Row(
                            children: [
                              Checkbox(value: false, onChanged: (bool? value) {}),
                              Text('Tất cả',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                            ],
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            Text('Tổng thanh toán: ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                            RichText(
                              text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: '1000000',
                                      style: const TextStyle(
                                          color: Colors.green,fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    const TextSpan(
                                      text: ".VNĐ",
                                      style: TextStyle(
                                          color: Colors.red, fontWeight: FontWeight.w600),
                                    ),
                                  ]),
                            ),]
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: size.width*0.2,
                    width: size.width*0.25,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
                      color: Colors.redAccent,
                    ),
                    child: TextButton(
                      onPressed: (){},
                        child: Text('Mua hàng',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),)
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10,left:10,right:10 ,bottom: 30),
                itemCount: cartArr.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index){
                  var cObj = cartArr[index] as Map? ?? {};
                  return CartItemWidget(cObj:cObj);
                },
              ),
            ),
          ]
        ),
      ),
    );
  }
}
