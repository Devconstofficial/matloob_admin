import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../utils/app_colors.dart';

class CustomDialog1 extends StatefulWidget {
  double intentPadding;
  Widget body;
  double width;
  CustomDialog1({super.key,
    this.intentPadding = 29,
    this.width = 450,
    required this.body
  });

  @override
  CustomDialog1State createState() => CustomDialog1State();
}

class CustomDialog1State extends State<CustomDialog1> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: widget.intentPadding,vertical:  widget.intentPadding),
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: widget.width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: kWhiteColor,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(23),
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
                widget.body
              ],
            ),
          ),
        ),
      ),
    );
  }
}
