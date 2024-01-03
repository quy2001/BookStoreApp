import 'package:bookstore/base/widgets/dialog_widget.dart';
import 'package:bookstore/user/cart/controller/cart_provider.dart';
import 'package:bookstore/user/cart/model/cart_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../common/values/assets.dart';
import '../../../../common/values/colors.dart';
import '../../../../common/values/styles.dart';

import '../../../book_details/screen/book_detail_screen.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget(
      {super.key,
      required this.listCart,
      required this.id
      });

  final Cart listCart;
  final int id;
  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late CartProvider cartProvider;

  void deletCart() {
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.deleteCart(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height: size.width * 0.38,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.listCart.bimage,
                width: size.width * 0.2,
                height: size.width * 0.3,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.listCart.bname,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: AppStyles.titleBook,
                ),
                const SizedBox(
                  height: 8,
                ),
                RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: widget.listCart.bprice.toString(),
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(
                          text: ".000",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(
                          text: " VNĐ",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w600),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 35.0,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: AppColors.button),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.primaryColor,
                                blurRadius: 2,
                                offset: Offset(0, 2),
                              )
                            ]),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => BookDetailScreen(
                                          id: widget.listCart.idBook,
                                          titleBook: widget.listCart.bname,
                                          statusBook: false,
                                          statusFavourite: false,
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: const Text(
                            'Xem sách',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return DialogWidget(
                                title: 'Thông báo',
                                icon: AppAssets.icoDialogNotice,
                                cancelButton: true,
                                content: 'Bạn muốn xóa sách khỏi giỏ hàng?',
                                function: () {
                                  deletCart();
                                  Navigator.pop(context);
                                },
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ],
        ));
  }
}
