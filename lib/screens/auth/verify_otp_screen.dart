import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/generated/locale_keys.g.dart';
import 'package:matloob_admin/utils/common_code.dart';
import 'package:otp_text_field/style.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../custom_widgets/auth_component.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';

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
            SvgPicture.asset(kLogoImage, height: 72.h, width: 150.w),
            SizedBox(height: 43.h),
            CustomText(
              text: CommonCode().t(LocaleKeys.enterOtp),
              fontWeight: FontWeight.w600,
              fontSize: 24.sp,
            ),
            SizedBox(height: 14.h),
            CustomText(
              text: CommonCode().t(LocaleKeys.enterOtpCodeSubtitle),
              fontWeight: FontWeight.w300,
              fontSize: 18.sp,
              color: kBlackColor.withOpacity(0.6),
            ),

            SizedBox(height: 32.h),

            OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceBetween,
              fieldWidth: 60,
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
                controller.code.value = pin;
              },
            ),
            SizedBox(height: 26.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: CommonCode().t(LocaleKeys.didntReceiveCode),
                  fontSize: 18.sp,
                  color: kBlackColor.withOpacity(0.6),
                  fontWeight: FontWeight.w300,
                ),
                Obx(
                  () =>
                      controller.isLoadingResent.value
                          ? const Center(child: CircularProgressIndicator())
                          : GestureDetector(
                            onTap: () async {
                              await controller.resendOtp();
                            },
                            child: CustomText(
                              text: CommonCode().t(LocaleKeys.resend),
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                            ),
                          ),
                ),
              ],
            ),

            SizedBox(height: 33.h),
            Obx(
              () =>
                  controller.isLoadingVerify.value
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                        title: CommonCode().t(LocaleKeys.verifyOtp),
                        onTap: () async {
                          await controller.verifyOtp();
                        },
                      ),
            ),

            SizedBox(height: 46.h),
          ],
        ),
      ),
    );
  }
}
