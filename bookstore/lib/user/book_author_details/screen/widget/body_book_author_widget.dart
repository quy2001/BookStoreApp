import 'package:flutter/material.dart';

import '../../../../base/controller/base_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import '../../../bookcase/controller/bookcase_provider.dart';
import '../../../search_book/screen/widget/search_history_widget.dart';
import '../../controller/book_author_provider.dart';


class BodyBookAuthorWidget extends StatefulWidget {
  const BodyBookAuthorWidget({super.key, required this.id});
  final int id;
  @override
  State<BodyBookAuthorWidget> createState() => _BodyBookAuthorWidgetState();
}

class _BodyBookAuthorWidgetState extends State<BodyBookAuthorWidget> {

  late BookAuthorProvider bookAuthorProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookAuthorProvider = Provider.of<BookAuthorProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookAuthorProvider.getBookAuthor(widget.id);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Selector<BookAuthorProvider, Status>(builder: (context, value, child) {
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
      return buildData(bookAuthorProvider);
    }, selector: (context, pro) {
      return pro.statusBookAuthor;
    });
  }
  Widget buildData(BookAuthorProvider provider) {
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
