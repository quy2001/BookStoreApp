import 'dart:ui';

class AppColors{
  static const Color primaryColor = Color(0xff5ABD8C);
  static const Color primaryLightColor = Color(0xffAFDFC7);
  static const Color bgColor = Color(0xffF3FDEC);
  static const Color subTitleColorBG = Color(0xff865A61);
  static const Color titleColor = Color(0xff212121);
  static const Color subTitleColor = Color(0xff242126);
  static Color get subTitle => const Color(0xff212121).withOpacity(0.4);
  static List<Color> get buttonColor => const [  Color(0xff5ABD8C), Color(0xff00FF81), ];
  static List<Color> get button => const [  Color(0xff5ABD8C), Color(0xff00FF81), ];
  static Color get textbox => const Color(0xffEFEFEF).withOpacity(0.6);
  static List<Color> get searchBGColor => const [
    Color(0xffB7143C),
    Color(0xffE6A500),
    Color(0xffEF4C45),
    Color(0xffF46217),
    Color(0xff09ADE2),
    Color(0xffD36A43),
  ];

}