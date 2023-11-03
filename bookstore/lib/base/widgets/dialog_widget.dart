import 'package:bookstore/common/values/assets.dart';
import 'package:bookstore/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DialogWidget extends StatelessWidget {
   DialogWidget({this.title, this.icon, this.cancelButton, this.content,this.function,super.key});

  String? title;
  String? content;
  String? icon;
  bool? cancelButton;
  Function()? function;

  @override
  Widget build(BuildContext context) {
    List<Widget> actionsWidget = [];
    if(cancelButton == true){
      actionsWidget.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  color: AppColors.primaryColor, // Màu sắc của viền
                  width: 1.0, // Độ dày của viền
                ),
                minimumSize: const Size(129, 40),
                foregroundColor: AppColors.primaryColor,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  // bo góc của button
                ),
              ),
              child: const Text(
                "Hủy",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700),
              )),
          //SizedBox(width:10 ,),
          ElevatedButton(
              onPressed: function ?? (){Navigator.pop(context);},
              style: ElevatedButton.styleFrom(
                //padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                minimumSize: const Size(129, 40),
                foregroundColor: Colors.white,
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // bo góc của button
                ),
              ),
              child: const Text(
                "Xác nhận",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700),
              )),
        ],
      ));
    }
    else{
      actionsWidget.add(
        Center(
          child: ElevatedButton(
              onPressed: function ?? (){Navigator.pop(context);},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 40),
                foregroundColor: Colors.white,
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // bo góc của button
                ),
              ),
              child: const Text(
                "Đóng",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700),
              )),
        ),);
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.all(16),
      icon: SvgPicture.asset(icon ?? AppAssets.icoDialogNotice),
      title: Text(
        title ?? "Thông báo",
        style: TextStyle(
          fontSize: 18,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w700
        ),
      ),
      content: Text(
        content ?? '',
        style: TextStyle(
          color: AppColors.subTitle,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
      actions: actionsWidget,
    );
  }
}
