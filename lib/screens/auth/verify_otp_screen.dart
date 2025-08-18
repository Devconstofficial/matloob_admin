import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/style.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/auth_component.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../utils/app_strings.dart';
import 'controller/auth_controller.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

class VerifyOtpScreen extends GetView<AuthController> {
  const VerifyOtpScreen({super.key});

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
            CustomText(text: kEnterOTPCode,fontWeight: FontWeight.w600,fontSize: 24.sp,),
            SizedBox(height: 14.h),
            CustomText(text: kEnterOTPCodeDetail,fontWeight: FontWeight.w300,fontSize: 18.sp,color: kBlackColor.withOpacity(0.6),),

            SizedBox(height: 32.h),

            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceBetween,
              fieldWidth: 60,
              // margin: EdgeInsets.only(left: 16),
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: kWhiteColor,
                  enabledBorderColor: kBlackColor,
                  borderColor: kBlackColor,
                  focusBorderColor: kPrimaryColor,
                  disabledBorderColor: kWhiteColor,
              ),
              fieldStyle: FieldStyle.box,
              contentPadding: EdgeInsets.symmetric(vertical: 25),
              outlineBorderRadius: 12.r,
              style: const TextStyle(fontSize: 17),
              onChanged: (pin) {

              },
              onCompleted: (pin) async {},
            ),
            SizedBox(height: 26.h),
            Center(child: CustomText(text: kResendCode,fontWeight: FontWeight.w300,fontSize: 18.sp,color: kBlackColor.withOpacity(0.6),)),

            SizedBox(height: 33.h),
            CustomButton(
              title: kVerifyOTP,
              onTap: () {
                Get.toNamed(kSetNewPassScreenRoute);
              },
            ),
            SizedBox(height: 46.h),
          ],
        ),
      ),

    );
  }
}
