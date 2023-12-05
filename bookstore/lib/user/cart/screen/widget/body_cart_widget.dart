import 'package:bookstore/user/cart/controller/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../base/controller/consumer_base.dart';
import 'appbar_cart.dart';
import 'cart_item_widget.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class BodyCartWidget extends StatefulWidget {
  const BodyCartWidget({super.key});

  @override
  State<BodyCartWidget> createState() => _BodyCartWidgetState();
}

class _BodyCartWidgetState extends State<BodyCartWidget> {
  late CartProvider listCartProvider;
  late List<bool> itemSelections;
  late bool _selectAll;
  @override
  void initState() {
    super.initState();
    listCartProvider = Provider.of<CartProvider>(context, listen: false);
    listCartProvider.listCart = [];
    itemSelections = List.generate(listCartProvider.listCart.length, (index) => false);
    _selectAll = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listCartProvider.getListCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarCartWidget(),
        ConsumerBase<CartProvider>(
        contextData: context,
        onRepository: (req) {
          CartProvider provider = req;
          if (provider.isLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ProgressHUD.of(context)?.show();
            });
          }
          return const SizedBox();
        },
        onRepositoryError: (req) {
          return Center(
              child: Text(
                req.messagesError ?? '',
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ));
        },
        onRepositoryNoData: (req) {
          return const Center(
            child: Text(
              'Không có dữ liệu',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          );
        },
        onRepositorySuccess: (rep) {
          CartProvider provider = rep;
          if (provider.isLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ProgressHUD.of(context)?.dismiss();
            });
          }
          itemSelections = List.generate(provider.listCart.length, (index) => false);
          return Expanded(
            child: ListView.builder(
              padding:
              EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
              itemCount: provider.listCart.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return CartItemWidget(
                  id: provider.listCart[index].id,
                  listCart: provider.listCart[index],
                  isSelected: itemSelections[index],
                  onSelectionChanged: (bool isSelected) {
                    setState(() {
                      itemSelections[index] = isSelected;
                      _selectAll = itemSelections.every((isSelected) => isSelected);
                    });
                  },
                );
              },
            ),
          );
        }),
      ],
    );

  }
}
