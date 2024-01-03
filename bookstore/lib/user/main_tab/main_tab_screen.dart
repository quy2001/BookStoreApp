import 'package:bookstore/common/values/colors.dart';
import 'package:bookstore/user/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../base/widgets/dialog_widget.dart';
import '../../common/values/assets.dart';
import '../account/screen/account_screen.dart';
import '../authors/screen/author_screen.dart';
import '../bookcase/screen/bookcase_screen.dart';
import '../cart/screen/cart_screen.dart';
import '../categories/screen/category_screen.dart';
import '../favourite/screen/favourite_screen.dart';
import '../login_user/screen/login_user_screen.dart';
import '../search_book/screen/search_book_screen.dart';

class MainTabScreen extends StatefulWidget {
  MainTabScreen({super.key});
  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

GlobalKey<ScaffoldState> sideMenuScaffoldKey = GlobalKey<ScaffoldState>();

class _MainTabScreenState extends State<MainTabScreen> {
  int currentTab = 0;

  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = HomeScreen();

  int selectMenu = 0;

  List menuArr = [
    {"name": "Trang chủ", "icon": Icons.home},
    {"name": "Sách yêu thích", "icon": Icons.favorite},
    {"name": "Sách của tôi", "icon": Icons.auto_stories},
    {"name": "Tác giả", "icon": Icons.perm_contact_cal},
    {"name": "Thể loại", "icon": Icons.category_outlined},
    {"name": "Tài khoản", "icon": Icons.account_circle},
    {"name": "Đăng xuất", "icon": Icons.logout},
  ];

  @override
  void initState() {
    sideMenuScaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  void dispose() {
    sideMenuScaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,//để FloatingActionButton không đi lên theo bàn phím
      key: sideMenuScaffoldKey,
      endDrawer: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        width: size.width * 0.7,
        child: Container(
          padding: const EdgeInsets.only(top: 64),
          decoration: BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(size.width * 0.6)),
              boxShadow: const [
                BoxShadow(color: Colors.black54, blurRadius: 15)
              ]),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: menuArr.map((mObj) {
                  var index = menuArr.indexOf(mObj);
                  return Container(
                      // margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 20),
                      decoration: selectMenu == index
                          ? const BoxDecoration(
                              color: AppColors.primaryColor,
                              boxShadow: [
                                  BoxShadow(
                                      color: AppColors.primaryColor,
                                      blurRadius: 10,
                                      offset: Offset(0, 3))
                                ])
                          : null,
                      child: GestureDetector(
                        onTap: () {
                          switch(index){
                            case 0:
                              setState(() {
                                currentScreen = HomeScreen();
                                currentTab = 0;
                              });
                              sideMenuScaffoldKey.currentState?.closeEndDrawer();
                            case 1:
                              setState(() {
                                currentScreen = FavouriteScreen();
                                currentTab = 5;
                              });
                              sideMenuScaffoldKey.currentState?.closeEndDrawer();
                            case 2:
                              setState(() {
                                currentScreen = BookcaseScreen();
                                currentTab = 1;
                              });
                              sideMenuScaffoldKey.currentState?.closeEndDrawer();
                            case 3:

                              setState(() {
                                currentScreen = AuthorScreen();
                                currentTab = 6;
                              });
                              sideMenuScaffoldKey.currentState?.closeEndDrawer();
                            case 4:
                              setState(() {
                                currentScreen = CategoryScreen();
                                currentTab = 7;
                              });
                              sideMenuScaffoldKey.currentState?.closeEndDrawer();
                            case 5:
                              setState(() {
                                currentScreen = AccountScreen();
                                currentTab = 3;
                              });
                              sideMenuScaffoldKey.currentState?.closeEndDrawer();
                            case 6:
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return DialogWidget(
                                      title: 'Thông báo',
                                      icon: AppAssets.icoDialogNotice,
                                      cancelButton: true,
                                      content: 'Bạn có muốn đăng xuất?',
                                      function: () async {
                                        //xóa token
                                        final prefs = await SharedPreferences.getInstance();
                                        prefs.remove('token');
                                        //chuyển qua trang login
                                        Navigator.pushReplacement(
                                            context, MaterialPageRoute(builder: (_) => LoginUserScreen()));
                                      },
                                    );
                                  }
                              );
                              // currentTab = 8;
                          }
                          setState(() {
                            selectMenu = index;
                          });
                        },

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              mObj["name"].toString(),
                              style: TextStyle(
                                  color: selectMenu == index
                                      ? Colors.white
                                      : AppColors.titleColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Icon(
                              mObj["icon"] as IconData? ?? Icons.home,
                              color: selectMenu == index
                                  ? Colors.white
                                  : AppColors.primaryColor,
                              size: 33,
                            )
                          ],
                        ),
                      ));
                }).toList()),
          ),
        ),
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: SizedBox(
            child: Icon(
          Icons.search,
          color: currentTab == 4 ? Colors.white : AppColors.primaryLightColor,
        )),
        onPressed: () {
          setState(() {
            currentScreen = SearchBookScreen();
            currentTab = 4;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: AppColors.primaryColor,
        notchMargin: 10,
        child: Container(
          height: 65,
          width: size.width,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MaterialButton(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    splashColor: AppColors.primaryLightColor,
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0
                              ? Colors.white
                              : AppColors.primaryLightColor,
                        ),
                        Text(
                          'Trang chủ',
                          style: TextStyle(
                            color: currentTab == 0
                                ? Colors.white
                                : AppColors.primaryLightColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.all(2),
                    splashColor: AppColors.primaryLightColor,
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        currentScreen = BookcaseScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.library_books_sharp,
                          color: currentTab == 1
                              ? Colors.white
                              : AppColors.primaryLightColor,
                        ),
                        Text(
                          'Tủ sách',
                          style: TextStyle(
                            color: currentTab == 1
                                ? Colors.white
                                : AppColors.primaryLightColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    padding: EdgeInsets.all(8),
                    splashColor: AppColors.primaryLightColor,
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        currentScreen = CartScreen();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: currentTab == 2
                              ? Colors.white
                              : AppColors.primaryLightColor,
                        ),
                        Text(
                          'Giỏ hàng',
                          style: TextStyle(
                            color: currentTab == 2
                                ? Colors.white
                                : AppColors.primaryLightColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.only(left: 8, right: 16),
                    splashColor: AppColors.primaryLightColor,
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        currentScreen = AccountScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 3
                              ? Colors.white
                              : AppColors.primaryLightColor,
                        ),
                        Text(
                          'Tài khoản',
                          style: TextStyle(
                            color: currentTab == 3
                                ? Colors.white
                                : AppColors.primaryLightColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
