import 'package:bookstore/common/values/colors.dart';
import 'package:flutter/material.dart';
import '../../../../base/controller/base_provider.dart';
import '../../../../common/values/styles.dart';
import '../../../book_category_details/screen/book_category_detail_screen.dart';
import '../../controller/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';


class BodyCategoryWidget extends StatefulWidget {
  const BodyCategoryWidget({super.key});

  @override
  State<BodyCategoryWidget> createState() => _BodyCategoryWidgetState();
}

class _BodyCategoryWidgetState extends State<BodyCategoryWidget> {

  late CategoryProvider categoryProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryProvider = Provider.of<CategoryProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryProvider.getCategory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.redAccent.withOpacity(0.3),
                ),
                child: Icon(
                  Icons.menu,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                "Danh sách thể loại",
                style: AppStyles.titleBlack,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Selector<CategoryProvider, Status>(
              builder: (context, value, child) {
                if(value==Status.loading){
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ProgressHUD.of(context)?.show();
                  });
                }else if ( value == Status.loaded){
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ProgressHUD.of(context)?.dismiss();
                  });
                }else if (value == Status.error) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ProgressHUD.of(context)?.dismiss();
                  });
                }
                return buildDataCategory(categoryProvider);
              },
              selector: (context, pro) {
                return pro.statusCategory;
              }),
        ],
      ),
    );
  }

  Widget buildDataCategory (CategoryProvider provider){
    return  Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: provider.categoryArr.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15),
              child: index == 0 ? SizedBox() : GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> BookCategoryDetailScreen(titleCategory:provider.categoryArr[index].name, id: provider.categoryArr[index].id,)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.menu_book_outlined,
                      size: 50,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 20,),
                    Text(
                      provider.categoryArr[index].name,
                      style: AppStyles.titleBookDetails,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

}
