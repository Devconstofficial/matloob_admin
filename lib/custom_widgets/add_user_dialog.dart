import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/custom_widgets/customDialog1.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/generated/locale_keys.g.dart';
import 'package:matloob_admin/screens/user_management/controller/user_controller.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import 'package:matloob_admin/utils/common_code.dart';
import '../utils/app_colors.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  UserController userController = Get.put(UserController());

  Widget customTextField(
    TextEditingController controller,
    String hintText, {
    int maxLines = 1,
    IconData? prefixIcon, // 🔑 Added optional icon
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.roboto(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: kBlackColor,
      ),
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: kBlackColor) : null,
        hintStyle: GoogleFonts.roboto(
          color: kBlackColor.withOpacity(0.5),
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kBlackColor.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kBlackColor.withOpacity(0.1)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog1(
      width: 770.w,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CommonCode().t(LocaleKeys.userDetails),
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 13.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(
                    nameController,
                    "John Doe",
                    prefixIcon: Icons.person_outline,
                  ),
                ),
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(
                    mobileController,
                    "+973001234567",
                    prefixIcon: Icons.phone_outlined,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 13.h),
          SizedBox(
            height: 48.h,
            child: customTextField(
              emailController,
              "abc@gmail.com",
              prefixIcon: Icons.email_outlined,
            ),
          ),

          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                title: CommonCode().t(LocaleKeys.cancel),
                onTap: () {
                  Get.back();
                },
                height: 40.h,
                width: 131.w,
                color: kWhiteColor,
                borderRadius: 12,
                borderColor: kBlackColor,
                textSize: 14,
                fontWeight: FontWeight.w400,
                textColor: kBlackColor,
              ),

              Obx(
                () =>
                    userController.isAdding.value
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                          title: CommonCode().t(LocaleKeys.addUser),
                          onTap: () async {
                            await userController.addUserInController(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              mobile: mobileController.text.trim(),
                            );
                            nameController.clear();
                            emailController.clear();
                            mobileController.clear();
                          },
                          height: 40.h,
                          width: 140.w,
                          borderRadius: 12,
                          textSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
