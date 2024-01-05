import 'package:bookstore/base/controller/base_provider.dart';
import 'package:bookstore/user/bookcase/controller/bookcase_provider.dart';
import 'package:bookstore/user/bookcase/screen/widget/bookcase_item_widget.dart';
import 'package:bookstore/user/bookcase/screen/widget/search_bookcase_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../../../common/values/colors.dart';
class BodyBookcaseWidget extends StatefulWidget {
  const BodyBookcaseWidget({super.key});

  @override
  State<BodyBookcaseWidget> createState() => _BodyBookcaseWidgetState();
}

class _BodyBookcaseWidgetState extends State<BodyBookcaseWidget> {
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
              return Expanded(
                  child: Container(
                    width: double.infinity,
                      height: double.infinity,
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 170,
                                height: 170,
                                child: Image.asset('assets/img/no_bookcase.png',fit: BoxFit.contain,),
                              ),
                              Text('tủ sách rỗng',style: TextStyle(fontSize: 20,color: AppColors.primaryColor, fontWeight: FontWeight.w600),)
                            ],
                          )
                      )
                  )
              );
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

