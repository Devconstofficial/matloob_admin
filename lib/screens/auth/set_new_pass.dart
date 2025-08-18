import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/custom_widgets/custom_dialog.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/auth_component.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../utils/app_strings.dart';
import 'controller/auth_controller.dart';

class SetNewPassScreen extends GetView<AuthController> {
  const SetNewPassScreen({super.key});

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
            CustomText(text: kCreateNewPassword,fontWeight: FontWeight.w600,fontSize: 24.sp,),
            SizedBox(height: 14.h),
            CustomText(text: kCreateNewPasswordDetail,fontWeight: FontWeight.w300,fontSize: 18.sp,color: kBlackColor.withOpacity(0.6),),

            SizedBox(height: 32.h),
            CustomText(text: kNewPassword,fontWeight: FontWeight.w500,fontSize: 13.sp,color: kGreyShade7Color,),
            SizedBox(height: 11.h),
            Obx(
                  () => CustomTextField(
                hintText: kNewPasswordHint,
                isObscure: controller.isPasswordHidden1.value,
                prefixIcon: kLockIcon,
                suffix: IconButton(
                  icon: Icon(
                    controller.isPasswordHidden1.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  color: kGreyShade7Color,
                  iconSize: 17,
                  onPressed: () {
                    controller.togglePasswordVisibility1();
                  },
                ),
                fillColor: kWhiteColor,
                isFilled: true,
              ),
            ),
            SizedBox(height: 14.h),
            CustomText(text: kConfirmNewPassword,fontWeight: FontWeight.w500,fontSize: 13.sp,color: kGreyShade7Color,),
            SizedBox(height: 11.h),
            Obx(
                  () => CustomTextField(
                hintText: kConfirmNewPasswordHint,
                isObscure: controller.isPasswordHidden2.value,
                prefixIcon: kLockIcon,
                suffix: IconButton(
                  icon: Icon(
                    controller.isPasswordHidden2.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  color: kGreyShade7Color,
                  iconSize: 17,
                  onPressed: () {
                    controller.togglePasswordVisibility2();
                  },
                ),
                fillColor: kWhiteColor,
                isFilled: true,
              ),
            ),
            SizedBox(height: 48.h),
            CustomButton(
              title: kUpdatePassword,
              onTap: () {
                Get.dialog(CustomDialog(image: kSuccessImage, title: kPasswordResetSuccessfully, detail: kPasswordResetSuccessfullyDetail,onTap: (){
                  Get.toNamed(kAuthScreenRoute);
                },btnText: kGoHome,));
              },
            ),
          ],
        ),
      ),

    );
  }
}
