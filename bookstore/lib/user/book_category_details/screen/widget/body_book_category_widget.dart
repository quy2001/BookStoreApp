import 'package:flutter/material.dart';
import '../../../../base/controller/base_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../../../search_book/controller/search_book_provider.dart';
import '../../../search_book/screen/widget/search_history_widget.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

class BodyBookCategoryWidget extends StatefulWidget {
  const BodyBookCategoryWidget({super.key, required this.id});
  final int id;
  @override
  State<BodyBookCategoryWidget> createState() => _BodyBookCategoryWidgetState();
}

class _BodyBookCategoryWidgetState extends State<BodyBookCategoryWidget> {

  late SearchBookProvider searchBookProvider;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
    searchBookProvider = Provider.of<SearchBookProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchBookProvider.resetPage();
      // searchBookProvider.getListBook();
      searchBookProvider.searchAuthCate(0,widget.id);
    });
  }

  Future<void> _scrollListener() async {

    searchBookProvider.loadMore();
  }

  Future<void> _refresh() async {
    searchBookProvider.refresh = true;
    searchBookProvider.resetPage(idCa: widget.id);
    // searchBookProvider.getListBook();
    searchBookProvider.searchAuthCate(0,widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Selector<SearchBookProvider, Status>(builder: (context, value, child) {
          if (value == Status.loading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ProgressHUD.of(context)?.show();
            });
          } else if (value == Status.loaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ProgressHUD.of(context)?.dismiss();
            });
          } else if (value == Status.error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ProgressHUD.of(context)?.dismiss();
            });
          } else if (value == Status.noData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ProgressHUD.of(context)?.dismiss();
            });
            //nếu k có sách thì hiển thị hàm hình k có dữ liệu
            return Center(child: Text('Không có dữ liệu'));
          }
          return buildData(searchBookProvider);
        }, selector: (context, pro) {
          return pro.statusBook;
        }),
      ],
    );
  }
  // Widget buildData(SearchBookProvider provider) {
  //   return Expanded(
  //     child: RefreshLoadmore(
  //       onLoadmore: _scrollListener,
  //       onRefresh: _refresh,
  //       isLastPage: false,
  //       child: ListView.builder(
  //           shrinkWrap: true,
  //           padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 25),
  //           itemCount: provider.listBook.length,
  //           itemBuilder: (context, index) {
  //             return SearchHistoryWidget(
  //                 listBook: provider.listBook[index],);
  //           }),
  //     ),
  //   );
  // }
  Widget buildData(SearchBookProvider provider) {
    return Expanded(
      child: RefreshLoadmore(
        onLoadmore: _scrollListener,
        onRefresh: _refresh,
        isLastPage: false,
        child: ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 25),
            itemCount: provider.listBookDisplay.length,
            itemBuilder: (context, index) {
              return SearchHistoryWidget(
                  listBook: provider.listBookDisplay[index]);
            }),
      ),
    );
  }
}
