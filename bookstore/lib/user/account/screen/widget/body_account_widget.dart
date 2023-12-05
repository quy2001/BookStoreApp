import 'package:bookstore/common/values/assets.dart';
import 'package:bookstore/common/values/colors.dart';
import 'package:bookstore/common/values/styles.dart';
import 'package:bookstore/user/account/screen/edit_account_screen.dart';
import 'package:bookstore/user/favourite/screen/favourite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../../../../base/controller/consumer_base.dart';
import '../../../home/screen/widget/best_seller_widget.dart';
import '../../controller/account_provider.dart';
import 'package:provider/provider.dart';

class BodyAccountWidget extends StatefulWidget {
  const BodyAccountWidget({super.key});

  @override
  State<BodyAccountWidget> createState() => _BodyAccountWidgetState();
}

class _BodyAccountWidgetState extends State<BodyAccountWidget> {

  late AccountProvider accountProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      accountProvider.getAccount();
    });
  }


  List bestSellerArr = [
    {
      "name": "The Dissapearance of Emila Zola",
      "author": "Michael Rosen",
      "img": "assets/img/1.jpg",
      "rating": 5.0
    },
    {
      "name": "Fatherhood",
      "author": "Marcus Berkmann ",
      "img": "assets/img/2.jpg",
      "rating": 4.0
    },
    {
      "name": "The Time Travellers Handbook",
      "author": "Stride Lottie",
      "img": "assets/img/3.jpg",
      "rating": 3.0
    },
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
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
                  return Column(
                    children: [
                      Text(pro.account.name, style: AppStyles.titleBookDetails,),
                      SizedBox(
                        height: 5,
                      ),
                      Text(pro.account.email, style: AppStyles.description,),
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
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> EditAccountScreen()));
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
            Container(
              width: size.width,
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.redAccent.withOpacity(0.3),
                    ),
                    child: Icon(
                        Icons.favorite,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Sách yêu thích",
                    style: AppStyles.titleBlack,
                    textAlign: TextAlign.start,
                  ),
                  Spacer(),
                 GestureDetector(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (_)=>FavouriteScreen()));
                   },
                   child: Row(
                     children: [
                       Text('Xem tất cả'),
                       Icon(
                           Icons.navigate_next_outlined
                       ),
                     ],
                   ),
                 )
                ],
              ),
            ),
            SizedBox(
              height: size.width,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  scrollDirection: Axis.horizontal,
                  itemCount: bestSellerArr.length,
                  itemBuilder: (context, index) {
                    var bObj = bestSellerArr[index] as Map? ?? {};
                    return BestSellerWidget(bObj:bObj);
                  }
              ),
            ),
            Divider(),
            AccountMenu(
              title: 'Thay đổi mật khẩu',
              icon: Icons.navigate_next_outlined,
              functionAccountMenu: (){},
              endIcon: false,
            ),
            AccountMenu(
              title: 'Đăng xuất',
              icon: Icons.logout,
              functionAccountMenu: (){},
            ),
          ],
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
