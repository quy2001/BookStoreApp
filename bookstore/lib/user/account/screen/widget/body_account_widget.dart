import 'package:bookstore/base/widgets/dialog_widget.dart';
import 'package:bookstore/common/values/assets.dart';
import 'package:bookstore/common/values/colors.dart';
import 'package:bookstore/common/values/styles.dart';
import 'package:bookstore/user/account/screen/edit_account_screen.dart';
import 'package:bookstore/user/account/screen/widget/list_favourite_widget.dart';
import 'package:bookstore/user/login_user/screen/login_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../base/controller/consumer_base.dart';
import '../../controller/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';
class BodyAccountWidget extends StatefulWidget {
  const BodyAccountWidget({super.key});

  @override
  State<BodyAccountWidget> createState() => _BodyAccountWidgetState();
}

class _BodyAccountWidgetState extends State<BodyAccountWidget> {

  late AccountProvider accountProvider;
  final ScrollController scrollController = ScrollController();

  late String name;
  late  String email;
  late int id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      accountProvider.getAccount();
    });
  }

  Future<void> _refresh() async {
    accountProvider.getAccount();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return RefreshLoadmore(
      onRefresh: _refresh,
      isLastPage: true,
      child: SingleChildScrollView(
        controller: scrollController,
        child:Container(
          width: size.width,
          padding: EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: size.width*0.35,
                      height: size.width*0.35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage(AppAssets.avatar),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.primaryColor,
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ConsumerBase<AccountProvider>(
                  contextData: context,
                  onRepository: (rep) {
                    AccountProvider pro = rep;
                    if (pro.isLoading) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ProgressHUD.of(context)?.show();
                      });
                    }
                    return const SizedBox();
                  },
                  onRepositoryError: (rep) {
                    return Center(
                        child: Text(
                          rep.messagesError ?? '',
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ));
                  },
                  onRepositoryNoData: (rep) {
                    return const Center(
                      child: Text(
                        'Không có dữ liệu',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    );
                  },
                  onRepositorySuccess: (rep) {
                    AccountProvider pro = rep;
                    if (pro.isLoaded) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ProgressHUD.of(context)?.dismiss();
                      });
                    }
                    name = pro.account.name;
                    email = pro.account.email;
                    id = pro.account.id;
                    return Column(
                      children: [
                        Text(name, style: AppStyles.titleBookDetails,),
                        SizedBox(
                          height: 5,
                        ),
                        Text(email, style: AppStyles.description,),
                      ],
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width*0.5,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> EditAccountScreen(name: name, email: email,)));
                      // _navigatorPushEdit(context);
                    },
                    child: Text('Sửa tài khoản',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    side: BorderSide.none,
                    shape: StadiumBorder()
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ListFavouriteWidget(),
              Divider(),
              AccountMenu(
                title: 'Thay đổi mật khẩu',
                icon: Icons.navigate_next_outlined,
                functionAccountMenu: (){},
                endIcon: false,
              ),
              GestureDetector(
                onTap: () {
                  //hiển thị thông báo đăng xuất
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
                },
                child: AccountMenu(
                  title: 'Đăng xuất',
                  icon: Icons.logout,
                  functionAccountMenu: (){},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountMenu extends StatelessWidget {
  const AccountMenu({
    super.key, required this.title, required this.icon,this.endIcon = true, this.functionAccountMenu,
  });

  final String title;
  final IconData icon;
  final Function()? functionAccountMenu;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
          height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.primaryLightColor.withOpacity(0.6),
        ),
        child: Icon(
            icon
        ),
      ),
      title: Text(title,
            style: TextStyle(color: Colors.black),
      ),
      trailing: endIcon? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.subTitle.withOpacity(0.09),
        ),
        child: Icon(
            Icons.navigate_next_outlined
        ),
      ) : SizedBox()
    );
  }
}
