import 'package:bookstore/user/authors/controller/author_provider.dart';
import 'package:flutter/material.dart';

import '../../../../base/controller/base_provider.dart';
import '../../../../common/values/assets.dart';
import '../../../../common/values/styles.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import '../../../book_author_details/screen/book_author_detail_screen.dart';
class BodyAuthorWidget extends StatefulWidget {
  const BodyAuthorWidget({super.key});

  @override
  State<BodyAuthorWidget> createState() => _BodyAuthorWidgetState();
}

class _BodyAuthorWidgetState extends State<BodyAuthorWidget> {

  late AuthorProvider authorProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authorProvider = Provider.of<AuthorProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authorProvider.getAuthor(context);
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
                "Danh sách tác giả",
                style: AppStyles.titleBlack,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(height: 20,),
          Selector<AuthorProvider, Status>(
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
                }
                return buildDataAuthor(authorProvider);
              }, selector: (context, pro) {
            return pro.statusAuthor;
          }),
        ],
      ),
    );
  }
  Widget buildDataAuthor (AuthorProvider provider){
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: provider.authorArr.length,
          itemBuilder: (context,index){
            return index == 0 ? SizedBox() : Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>BookAuthorDetailScreen(titleAuthor: provider.authorArr[index].name, id: provider.authorArr[index].id,)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(AppAssets.avatar),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Text(
                      provider.authorArr[index].name,
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
