import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class CustomDialog extends StatefulWidget {
  double intentPadding;
  String image;
  String title;
  String detail;
  String btnText;
  double width;
  VoidCallback? onTap;
  CustomDialog({super.key,
    this.intentPadding = 29,
    this.width = 450,
    required this.image,
    required this.title,
    required this.detail,
    this.btnText = '',
    this.onTap,
  });

  @override
  CustomDialogState createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: widget.intentPadding),
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        width: widget.width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: kWhiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(46),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        height: 38.h,
                        width: 42.w,
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: kWhiteShade5Color.withOpacity(0.25),
                              offset: Offset(0, 4),
                              blurRadius: 22,
                              spreadRadius: 0
                            )
                          ]
                        ),
                        child: Icon(Icons.close,size: 16,color: kBlackColor,),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 26.h,),
              Center(
                child: SizedBox(
                  height: 170.h,
                  width: 160.w,
                  child: Image.asset(widget.image,fit: BoxFit.cover,),
                ),
              ),
              SizedBox(height: 12.h,),
              Text(widget.title,style: AppStyles.blackTextStyle().copyWith(fontSize: 24.sp,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              SizedBox(height: 2.h,),
              Text(widget.detail,style: AppStyles.blackTextStyle().copyWith(fontSize: 16.sp,fontWeight: FontWeight.w200),textAlign: TextAlign.center,),
              SizedBox(height: 25.h,),
              CustomButton(title: widget.btnText, onTap: widget.onTap ?? (){})
            ],
          ),
        ),
      ),
    );
  }
}
