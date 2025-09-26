import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/custom_widgets/custom_text.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../custom_widgets/auth_component.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../utils/app_strings.dart';
import 'controller/auth_controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

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
            CustomText(text: kSignIn,fontWeight: FontWeight.w600,fontSize: 24.sp,),
            SizedBox(height: 37.h),
            CustomText(text: kEmail,fontWeight: FontWeight.w500,fontSize: 13.sp,color: kGreyShade7Color,),
            SizedBox(height: 11.h),
            CustomTextField(
              hintText: kEmailHint,
              prefixIcon: kMailIcon,
              fillColor: kWhiteColor,
              controller: controller.emailCont,
              isFilled: true,
            ),
            SizedBox(height: 32.h),
            CustomText(text: kPassword,fontWeight: FontWeight.w500,fontSize: 13.sp,color: kGreyShade7Color,),
            SizedBox(height: 11.h),
            Obx(
                  () => CustomTextField(
                hintText: kPasswordHint,
                controller: controller.passwordCont,
                isObscure: controller.isPasswordHidden.value,
                prefixIcon: kLockIcon,
                suffix: IconButton(
                  icon: Icon(
                    controller.isPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  color: kGreyShade7Color,
                  iconSize: 17,
                  onPressed: () {
                    controller.togglePasswordVisibility();
                  },
                ),
                fillColor: kWhiteColor,
                isFilled: true,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(kSendOtpScreenRoute);
                    },
                    child: CustomText(text: kForgotPassword,fontWeight: FontWeight.w300,fontSize: 12.sp,color: kBlackShade10Color,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 71.h),
            Obx(
              () =>
                  controller.isLoadingLogin.value
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                        title: kLogin,
                        onTap: () async {
                          await controller.loginUser();
                        },
                        height: 62,
                      ),
            ),
            
          ],
        ),
      ),
    );
  }
}
