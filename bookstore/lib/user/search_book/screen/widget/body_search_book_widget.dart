import 'package:bookstore/user/search_book/controller/search_book_provider.dart';
import 'package:bookstore/user/search_book/screen/widget/search_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../../../../base/controller/base_provider.dart';
import '../../../../common/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

import '../../controller/author_provider.dart';
import '../../controller/category_provider.dart';

class BodySearchBookWidget extends StatefulWidget {
  const BodySearchBookWidget({super.key});

  @override
  State<BodySearchBookWidget> createState() => _BodySearchBookWidgetState();
}

class _BodySearchBookWidgetState extends State<BodySearchBookWidget> {
  late int valueAuthor = authorProvider.authorArr[0].id;
  late int valueCategory = categoryProvider.categoryArr[0].id;
  final ScrollController scrollController = ScrollController();
  late SearchBookProvider searchBookProvider;
  late AuthorProvider authorProvider;
  late CategoryProvider categoryProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
    searchBookProvider = Provider.of<SearchBookProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchBookProvider.resetPage();
      searchBookProvider.getListBook();
    });
    authorProvider = Provider.of<AuthorProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authorProvider.getAuthor(context);
    });
    categoryProvider = Provider.of<CategoryProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryProvider.getCategory(context);
    });
  }

  Future<void> _scrollListener() async {
    searchBookProvider.loadMore();
  }

  Future<void> _refresh() async {
    searchBookProvider.refresh = true;
    searchBookProvider.resetPage();
    searchBookProvider.getListBook();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text('Tác giả',style: TextStyle(color: AppColors.primaryColor,fontSize: 18,fontWeight: FontWeight.w700),),
                      SizedBox(width: 15,),
                      Container(
                        width: size.width *0.6,
                        height: size.width * 0.08,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.subTitle, width: 1),
                        ),
                        child: Selector<AuthorProvider, Status>(
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
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text('Thể loại',style: TextStyle(color: AppColors.primaryColor,fontSize: 18,fontWeight: FontWeight.w700),),
                      SizedBox(width: 10,),
                      Container(
                        width: size.width * 0.6,
                        height: size.width * 0.08,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.subTitle, width: 1),
                        ),
                        child: Selector<CategoryProvider, Status>(
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
                            })
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              IconButton(
                  onPressed: () {
                    searchBookProvider.searchAuthCate(valueAuthor, valueCategory);
                  }, icon: Icon(Icons.filter_alt_outlined,size: 35,))
            ],
          ),
        ),
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
            return Text('Không có dữ liệu');
          }
          return buildData(searchBookProvider);
        }, selector: (context, pro) {
          return pro.statusBook;
        }),
      ],
    );
  }

  Widget buildDataAuthor( AuthorProvider provider) {
    return Center(
      child: DropdownButton(
        underline: Container(),
        isExpanded: true,
        value: provider.authorArr.isNotEmpty? valueAuthor : 0,
        items: provider.authorArr.isNotEmpty
            ? provider.authorArr.map((author) {
          return DropdownMenuItem(
            value: author.id, // Đảm bảo giá trị là duy nhất, ví dụ: author.id
            child: Text(author.name.toString()),
          );
        }).toList()
            : [],
        onChanged: (value) {
          setState(() {
            valueAuthor = value as int;
          });
        },
      ),
    );
  }

  Widget buildDataCategory(CategoryProvider provider) {
    return Center(
      child: DropdownButton(
        underline: Container(),
        isExpanded: true,
        value:provider.categoryArr.isNotEmpty ? valueCategory : 0,
        items: provider.categoryArr.isNotEmpty
            ? provider.categoryArr
            .map((category) {
          return DropdownMenuItem(
            value: category.id,
            child: Text(category.name.toString()),
          );
        }).toList()
            : [],
        onChanged: (value) {
          setState(() {
            valueCategory = value as int;
          });
        },
      ),
    );
  }

  Widget buildData(SearchBookProvider provider) {
    return Expanded(
      child: RefreshLoadmore(
        onLoadmore: _scrollListener,
        onRefresh: _refresh,
        isLastPage: false,
        child: ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 25),
            itemCount: provider.listBookDisplay.length,
            itemBuilder: (context, index) {
              return SearchHistoryWidget(
                  listBook: provider.listBookDisplay[index]);
            }),
      ),
    );
  }
}
