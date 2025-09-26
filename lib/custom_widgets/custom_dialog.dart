import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../utils/app_strings.dart';

class CustomDialog extends StatefulWidget {
  double intentPadding;
  String image;
  String title;
  String detail;
  String btnText;
  double width;
  bool hideDetail;
  bool showRejection;
  Color btnColor;
  VoidCallback? onTap;
  final TextEditingController? reasonController;
  RxBool? isLoading;

  CustomDialog({super.key,
    this.intentPadding = 29,
    this.width = 450,
    required this.image,
    required this.title,
    this.detail = '',
    this.btnText = '',
    this.hideDetail = false,
    this.showRejection = false,
    this.btnColor = kPrimaryColor,
    this.onTap,
    this.reasonController,
    this.isLoading 
  });

  @override
  CustomDialogState createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog> {

  customTextField1(hintText,{int maxLines = 1,EdgeInsets contentPadding = const EdgeInsets.symmetric(vertical: 0,horizontal: 20),}){
    return TextField(
      controller: widget.reasonController,
      style: GoogleFonts.roboto(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: kBlackColor,
      ),
      maxLines: maxLines,
      decoration: InputDecoration(
        hintStyle: GoogleFonts.roboto(
          color: kBlackColor.withOpacity(0.5),
          fontWeight: FontWeight.w300,
          fontSize: 13.sp,
        ),
        hintText: hintText,
        contentPadding: contentPadding,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: kBlackColor.withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: kBlackColor.withOpacity(0.1),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: widget.intentPadding),
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: widget.width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: kWhiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: widget.showRejection == true
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
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
                  child: Image.asset(widget.image,fit: BoxFit.contain,),
                ),
              ),
              SizedBox(height: 12.h,),
              Text(widget.title,style: AppStyles.blackTextStyle().copyWith(fontSize: 24.sp,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              SizedBox(height: 2.h,),
              if(widget.showRejection == true)
                customTextField1(kProjectDescriptionHint,maxLines: 4,contentPadding: EdgeInsets.all(16)),
              widget.hideDetail == true
                  ? SizedBox()
                  : Text(
                widget.detail,
                style: AppStyles.blackTextStyle().copyWith(fontSize: 16.sp,fontWeight: FontWeight.w200),textAlign: TextAlign.center,),
              SizedBox(height: widget.hideDetail == true ? 43.h : 25.h,),
              Obx(()=> widget.isLoading!.value? const Center(child: CircularProgressIndicator(),): CustomButton(title: widget.btnText, onTap: widget.onTap ?? (){},color: widget.btnColor,borderColor: widget.btnColor,))
            ],
          ),
        ),
      ),
    );
  }
}
