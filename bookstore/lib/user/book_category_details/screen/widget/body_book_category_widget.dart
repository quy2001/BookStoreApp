import 'package:flutter/material.dart';

import '../../../../base/controller/base_provider.dart';
import '../../../bookcase/controller/bookcase_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import '../../../search_book/screen/widget/search_history_widget.dart';
import '../../controller/book_category_provider.dart';

class BodyBookCategoryWidget extends StatefulWidget {
  const BodyBookCategoryWidget({super.key, required this.id});
  final int id;
  @override
  State<BodyBookCategoryWidget> createState() => _BodyBookCategoryWidgetState();
}

class _BodyBookCategoryWidgetState extends State<BodyBookCategoryWidget> {

  late BookCategoryProvider bookCategoryProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookCategoryProvider = Provider.of<BookCategoryProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookCategoryProvider.getBookCategory(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<BookCategoryProvider, Status>(builder: (context, value, child) {
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
      return buildData(bookCategoryProvider);
    }, selector: (context, pro) {
      return pro.statusBookCategory;
    });
  }
  Widget buildData(BookCategoryProvider provider) {
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
