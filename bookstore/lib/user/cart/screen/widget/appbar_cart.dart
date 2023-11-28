import 'package:flutter/material.dart';

import '../../../../common/values/colors.dart';
import '../../model/cart_response.dart';

class AppBarCartWidget extends StatefulWidget {
  const AppBarCartWidget({super.key, required this.listCart, required this.itemSelections, required this.updateTotal, required this.onSelectAllChanged});
  final List<bool> itemSelections;
  final List<Cart> listCart;
  final Function(List<Cart>) updateTotal;
  final Function(bool) onSelectAllChanged; // Callback để cập nhật trạng thái "Tất cả"

  @override
  State<AppBarCartWidget> createState() => _AppBarCartWidgetState();

  static _AppBarCartWidgetState? of(BuildContext context) {
    final state = context.findAncestorStateOfType<_AppBarCartWidgetState>();
    return state;
  }

}

class _AppBarCartWidgetState extends State<AppBarCartWidget> {
  late double totalPrice;
  late bool _selectAll;
  @override
  void initState() {
    super.initState();
    totalPrice = calculateTotalPrice(widget.listCart);
    _selectAll = false;
  }

  void updateTotal(List<Cart> selectedItems) {
    setState(() {
      totalPrice = calculateTotalPrice(selectedItems);
    });
  }
  double calculateTotalPrice(List<Cart> selectedItems) {
    double total = 0;
    for (var cart in selectedItems) {
      total += cart.bprice;
    }
    return total;
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Container(
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
                      Checkbox(
                          value: _selectAll,
                          activeColor: AppColors.primaryColor,
                          onChanged: (bool? value) {
                            setState(() {
                              _selectAll = value ?? false;
                              for (var i = 0; i < widget.itemSelections.length; i++) {
                                widget.itemSelections[i] = _selectAll;
                              }
                              widget.onSelectAllChanged(_selectAll); // Gọi callback khi trạng thái "Tất cả" thay đổi
                              widget.updateTotal(widget.listCart);
                            });
                      }),
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
                                text: totalPrice.toStringAsFixed(0),
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
    );
  }
  bool areAllItemsSelected() {
    for (var selected in widget.itemSelections) {
      if (!selected) {
        return false;
      }
    }
    return true;
  }
}

