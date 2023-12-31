import 'package:bookstore/base/controller/base_provider.dart';
import 'package:bookstore/user/bookcase/controller/bookcase_provider.dart';
import 'package:bookstore/user/bookcase/screen/widget/bookcase_item_widget.dart';
import 'package:bookstore/user/bookcase/screen/widget/search_bookcase_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
class BodyBookcaseWidget extends StatefulWidget {
  const BodyBookcaseWidget({super.key});

  @override
  State<BodyBookcaseWidget> createState() => _BodyBookcaseWidgetState();
}

class _BodyBookcaseWidgetState extends State<BodyBookcaseWidget> {

  // List searchArr = [
  //   {
  //     "name": "Biography dsfdsf afdaf afasdfa fadf ",
  //     "img": "assets/img/1.jpg",
  //   },
  //   {
  //     "name": "Tôi là bê tô",
  //     "img": "assets/img/toi_la_be_to.jpg",
  //   },
  //   {
  //     "name": "Children",
  //     "img": "assets/img/3.jpg",
  //   },
  //   {
  //     "name": "Bơ đi mà sống",
  //     "img": "assets/img/bo_di_ma_song.jpg",
  //   },
  //   {
  //     "name": "Business",
  //     "img": "assets/img/2.jpg",
  //   },
  //   {
  //     "name": "Tôi là bê tô",
  //     "img": "assets/img/toi_la_be_to.jpg",
  //   },
  //   {
  //     "name": "Business",
  //     "img": "assets/img/2.jpg",
  //   },
  // ];

  late BookcaseProvider bookcaseProvider;

  @override
  void initState() {
    super.initState();
    bookcaseProvider = Provider.of<BookcaseProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bookcaseProvider.getListBookcase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
      child: Column(
        children: [
          SearchBookcaseWidget(),
          SizedBox(height: 20,),

          Selector<BookcaseProvider,Status>(builder: (context,value,child){
            if(value == Status.loading){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ProgressHUD.of(context)?.show();
              });
            }else if(value == Status.loaded){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ProgressHUD.of(context)?.dismiss();
              });
            }else if (value == Status.error){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ProgressHUD.of(context)?.dismiss();
              });
            }else if (value == Status.noData){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ProgressHUD.of(context)?.dismiss();
              });
              return Text('Không có dữ liệu');
            }
            return buildData(bookcaseProvider);
          }, selector: (context,pro){
            return pro.statusBookCase;
          }),
        ],
      ),
    );
  }

  Widget buildData (BookcaseProvider provider){
    return Expanded(
      child: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.75,
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: provider.listBookcase.length,
          itemBuilder: (context, index) {
            // var sObj = searchArr[index] as Map? ?? {};
            return BookCaseItemWidget(
              bookcase: provider.listBookcase[index],
              index: index,
            );
          }
      ),
    );
  }

}

