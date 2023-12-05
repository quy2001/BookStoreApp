import 'package:flutter/material.dart';

import '../../../../base/controller/base_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../../../search_book/controller/search_book_provider.dart';
import '../../../search_book/screen/widget/search_history_widget.dart';


class BodyBookAuthorWidget extends StatefulWidget {
  const BodyBookAuthorWidget({super.key, required this.id});
  final int id;
  @override
  State<BodyBookAuthorWidget> createState() => _BodyBookAuthorWidgetState();
}

class _BodyBookAuthorWidgetState extends State<BodyBookAuthorWidget> {

  late SearchBookProvider searchBookProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchBookProvider = Provider.of<SearchBookProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchBookProvider.resetPage();
      searchBookProvider.getListBook();
      searchBookProvider.searchAuthCate(widget.id, 0);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Selector<SearchBookProvider, Status>(builder: (context, value, child) {
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
    });
  }
  Widget buildData(SearchBookProvider provider) {
    return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 25),
          itemCount: provider.listBook.length,
          itemBuilder: (context, index) {
            return SearchHistoryWidget(
                listBook: provider.listBook[index],);
          });
  }
}
