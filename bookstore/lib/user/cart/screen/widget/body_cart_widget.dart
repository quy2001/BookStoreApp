import 'package:bookstore/common/values/colors.dart';
import 'package:bookstore/user/cart/controller/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../base/controller/consumer_base.dart';
import 'appbar_cart.dart';
import 'cart_item_widget.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

class BodyCartWidget extends StatefulWidget {
  const BodyCartWidget({super.key});

  @override
  State<BodyCartWidget> createState() => _BodyCartWidgetState();
}

class _BodyCartWidgetState extends State<BodyCartWidget> {
  late CartProvider listCartProvider;
  final ScrollController scrollController = ScrollController();

  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    listCartProvider = Provider.of<CartProvider>(context, listen: false);
    listCartProvider.listCart = [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listCartProvider.getListCart();
    });
  }

  Future<void> _refresh() async {
    listCartProvider.getListCart();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ConsumerBase<CartProvider>(
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: Image.asset('assets/img/no_cart.png',fit: BoxFit.contain,),
                ),
                Text('giỏ hàng rỗng',style: TextStyle(fontSize: 20,color: AppColors.primaryColor, fontWeight: FontWeight.w600),)
              ],
            )
          );
        },
        onRepositorySuccess: (rep) {
          CartProvider provider = rep;
          if (provider.isLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ProgressHUD.of(context)?.dismiss();
            });
          }

          return Column(
            children: [
              AppBarCartWidget(totalPrice: provider.totalPrice(),),
              Expanded(
                child: RefreshLoadmore(
                  onRefresh: _refresh,
                  isLastPage: false,
                  child: ListView.builder(
                    padding:
                        EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: provider.listCart.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                        id: provider.listCart[index].id,
                        listCart: provider.listCart[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }

}
