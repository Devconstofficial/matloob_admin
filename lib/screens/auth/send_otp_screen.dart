import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/auth_component.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../utils/app_strings.dart';
import 'controller/auth_controller.dart';

class SendOtpScreen extends GetView<AuthController> {
  const SendOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AuthComponent(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(kLogoImage,height: 72.h,width: 150.w,),
            SizedBox(height: 43.h),
            CustomText(text: kForgotPassword,fontWeight: FontWeight.w600,fontSize: 24.sp,),
            SizedBox(height: 14.h),
            CustomText(text: kForgotPasswordDetail,fontWeight: FontWeight.w300,fontSize: 18.sp,color: kBlackColor.withOpacity(0.6),),
            SizedBox(height: 32.h),

            CustomText(text: kEmail,fontWeight: FontWeight.w500,fontSize: 13.sp,color: kGreyShade7Color,),
            SizedBox(height: 11.h),
            CustomTextField(
              hintText: kEmailHint,
              prefixIcon: kMailIcon,
              fillColor: kWhiteColor,
              isFilled: true,
            ),
            SizedBox(height: 72.h),
            CustomButton(
              title: kSendCode,
              onTap: () {
                Get.toNamed(kVerifyOtpScreenRoute);
              },
            ),
          ],
        ),
      ),

    );
  }
}
