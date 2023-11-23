import 'package:flutter/material.dart';

import '../../../../common/values/colors.dart';
import '../../../../common/values/styles.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({super.key, required this.cObj});
  final Map cObj;

  // int id;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  bool? _isChecked = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.width*0.38,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      margin:const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
            child: Image.asset(
              widget.cObj['img'],
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.cObj['name'],
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: AppStyles.titleBook,
                    ),
                  ),
                  Checkbox(value: _isChecked,
                      activeColor: AppColors.primaryColor,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      }),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: widget.cObj['price'],
                        style: const TextStyle(
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
                          gradient: LinearGradient(
                              colors:  AppColors.button),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.primaryColor,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: ElevatedButton(
                        onPressed: () {},
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          )
          ),
        ],
      ),
    );
  }
}
