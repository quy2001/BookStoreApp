import 'package:bookstore/user/search_book/controller/search_book_provider.dart';
import 'package:bookstore/user/search_book/screen/widget/search_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../../../../base/controller/base_provider.dart';
import '../../../../common/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

import 'filter_author_category_widget.dart';

class BodySearchBookWidget extends StatefulWidget {
  const BodySearchBookWidget({super.key});

  @override
  State<BodySearchBookWidget> createState() => _BodySearchBookWidgetState();
}

class _BodySearchBookWidgetState extends State<BodySearchBookWidget> {
  late SearchBookProvider searchBookProvider;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
    searchBookProvider = Provider.of<SearchBookProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchBookProvider.resetPage();
      searchBookProvider.getListBook();
    });
  }
  Future<void> _scrollListener() async {
    searchBookProvider.loadMore();
  }
  Future<void> _refresh() async{
    searchBookProvider.refresh = true;
    searchBookProvider.resetPage();
    searchBookProvider.getListBook();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterAuthCate(),
        Selector<SearchBookProvider, Status>(
            builder: (context, value, child) {
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
              }
              return buildData(searchBookProvider);
            }, selector: (context, pro) {
          return pro.statusBook;
        }),

        // Expanded(
        //   child: ListView.builder(
        //       padding: EdgeInsets.only(top:5,left: 10,right: 10, bottom: 25),
        //       itemCount: sResultArr.length,
        //       itemBuilder: (context,index){
        //         var srObj = sResultArr[index] as Map? ?? {};
        //         return SearchHistoryWidget(srObj: srObj,);
        //       }
        //   ),
        // )
      ],
    );
  }
  Widget buildData(SearchBookProvider provider ){
    return Expanded(
      child: RefreshLoadmore(
        onLoadmore: _scrollListener,
        onRefresh: _refresh ,
        isLastPage: false,
        child: ListView.builder(
          controller: scrollController,
            shrinkWrap: true,
            padding: EdgeInsets.only(top:5,left: 10,right: 10, bottom: 25),
            itemCount: provider.listBookDisplay.length,
            itemBuilder: (context,index){
              // var srObj = sResultArr[index] as Map? ?? {};
              return SearchHistoryWidget(listBook: provider.listBookDisplay[index]);
            }
        ),
      ),
    );
  }
}

