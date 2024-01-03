import 'package:bookstore/user/payment/payment_web_screen.dart';
import 'package:flutter/material.dart';

class AppBarCartWidget extends StatefulWidget {
   AppBarCartWidget({super.key, required this.totalPrice});
  int totalPrice;
  @override
  State<AppBarCartWidget> createState() => _AppBarCartWidgetState();
}

class _AppBarCartWidgetState extends State<AppBarCartWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: size.width * 0.17,
      width: size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
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
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
                children: [
                  const Text(
                    'Tổng thanh toán: ',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text:widget.totalPrice.toString(),
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const TextSpan(
                            text: ".000",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const TextSpan(
                            text: " VNĐ",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                          ),
                        ]),
                  ),
                ]),
          ),
          Spacer(),
          Container(
            height: size.width * 0.17,
            width: size.width * 0.25,
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.only(bottomRight: Radius.circular(30)),
              color: Colors.redAccent,
            ),
            child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>PaymentWebScreen()));
                },
                child: Text(
                  'Mua',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
            ),
          )
        ],
      ),
    );
  }
}
