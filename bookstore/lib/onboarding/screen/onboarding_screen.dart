import 'package:bookstore/common/values/assets.dart';
// import 'package:bookstore/onboarding/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import '../../common/values/colors.dart';
import '../../user/login_user/screen/login_user_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int page = 0;
  PageController? pageController = PageController();

  List pageArr = [
    {
      "title": "Discounted\nSecondhand Books",
      "sub_title": "Used and near new secondhand books at great prices.",
      "img": AppAssets.imgOn1,
    },
    {
      "title": "20 Book Grocers\nNationally",
      "sub_title": "We've successfully opened 20 stores across Australia.",
      "img": AppAssets.imgOn2,
    },
    {
      "title": "Sell or Recycle Your Old\nBooks With Us",
      "sub_title":
          "If you're looking to downsize, sell or recycle old books, the Book Grocer can help.",
      "img": AppAssets.imgOn3,
    },
  ];

  @override
  void initState() {
    super.initState();
    pageController?.addListener(() {
      page = pageController!.page!.round() ?? 0;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: pageArr.length,
              itemBuilder: (context, index) {
                var pageObject = pageArr[index] as Map? ?? {};
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50,left: 15,right: 15),
                    child: Column(
                      children: [
                        Text(
                          pageObject["title"].toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        Image.asset(
                          pageObject["img"].toString(),
                          width: size.width * 0.8,
                          height: size.width * 0.8,
                          fit: BoxFit.fitWidth,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          pageObject["sub_title"].toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.subTitleColorBG,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginUserScreen()));
                            },
                            child: const Text(
                              "Skip",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: pageArr.map((pageObject) {
                            var index = pageArr.indexOf(pageObject);
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  color: page == index
                                      ? AppColors.primaryColor
                                      : AppColors.primaryLightColor,
                                  borderRadius: BorderRadius.circular(7.5)),
                            );
                          }).toList(),
                        ),
                        TextButton(
                            onPressed: () {

                              if(page < 2) {
                                page = page + 1;
                                pageController?.jumpToPage(page);
                              }else{
                                Navigator.push(context, MaterialPageRoute(builder: ( context
                                    ) => const LoginUserScreen()  ));
                              }
                            },
                            child: Text(
                              page!=2 ? "Next" : "Get started",
                              style: const TextStyle(
                                  color: AppColors.primaryColor, fontSize: 20, fontWeight: FontWeight.w600),
                            )),
                      ]),
                ),
                SizedBox(
                  height: size.width * 0.15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
