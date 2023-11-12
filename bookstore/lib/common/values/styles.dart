import 'dart:ui';

import 'package:bookstore/common/values/colors.dart';
import 'package:flutter/material.dart';

class FontFamily {
  static final san = 'Open Sans';
  static final inter = 'Inter';
}

class AppStyles {
  static const TextStyle titleWhite =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white);
  static const TextStyle titleBlack =
  TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: Colors.black);
  static const TextStyle titleBook = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.titleColor);
  static const TextStyle subTitle =
      TextStyle(fontSize: 13, color: AppColors.subTitleColorBG);
  static const TextStyle description =
  TextStyle(fontSize: 13, color: AppColors.subTitleColor);

  static const TextStyle titleBookDetails = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 20, color: AppColors.titleColor);
}
