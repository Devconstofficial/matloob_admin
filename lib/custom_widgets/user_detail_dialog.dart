import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/custom_widgets/customDialog1.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/generated/locale_keys.g.dart';
import 'package:matloob_admin/models/user_analytics_model.dart';
import 'package:matloob_admin/screens/auth/controller/auth_controller.dart';
import 'package:matloob_admin/screens/user_management/controller/user_controller.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import 'package:matloob_admin/utils/common_code.dart';
import '../utils/app_colors.dart';
import 'custom_dropdown.dart';

class UserDetailModel extends StatefulWidget {
  RxString selectedStatus;
  UserWithAnalytics user;

  UserDetailModel({
    super.key,
    required this.selectedStatus,
    required this.user,
  });

  @override
  State<UserDetailModel> createState() => _UserDetailModelState();
}

class _UserDetailModelState extends State<UserDetailModel> {
  late TextEditingController nameController;
  late TextEditingController mobileController;
  late TextEditingController companyController;
  late TextEditingController emailController;
  UserController userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name ?? '');
    mobileController = TextEditingController(text: widget.user.mobile ?? '');
    companyController = TextEditingController(
      text: widget.user.companyName ?? '',
    );
    emailController = TextEditingController(text: widget.user.email ?? '');
    widget.selectedStatus.value = widget.user.status;
  }

  Widget customTextField(
    TextEditingController controller,
    String hintText, {
    int maxLines = 1,
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

  customContainer({
    bool isColored = false,
    String title = '',
    String detail = '',
  }) {
    return Container(
      height: 39.h,
      width: Get.width,
      decoration: BoxDecoration(
        color: isColored == true ? kCreamColor3 : kWhiteColor,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: kBlackColor.withOpacity(0.6),
              ),
            ),
            Text(
              detail,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: kBlackShade1Color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AuthController controller = Get.put(AuthController());

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
                  child: customTextField(nameController, "John Doe"),
                ),
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(mobileController, "+973001234567"),
                ),
              ),
            ],
          ),
          SizedBox(height: 13.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(companyController, "Lakreen"),
                ),
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(emailController, "abc@gmail.com"),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            CommonCode().t(LocaleKeys.requestForQuotation),
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 18.h),

          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: kBlackColor.withOpacity(0.1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 3,
                    children: [
                      Text(
                        CommonCode().t(LocaleKeys.totalRfqs),
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Text(
                        widget.user.totalRfqs.toString(),
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: kBlackColor.withOpacity(0.1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 3,
                    children: [
                      Text(
                        CommonCode().t(LocaleKeys.rfqWithSupplierResponse),
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Text(
                        widget.user.rfqSupplierResponse.toString(),
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: kBlackColor.withOpacity(0.1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 3,
                    children: [
                      Text(
                        CommonCode().t(LocaleKeys.rfqWithoutSupplierResponse),
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Text(
                        widget.user.rfqNoResponse.toString(),
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            CommonCode().t(LocaleKeys.userStatus),
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 17.h),
          CustomDropdown(
            selected: widget.selectedStatus,
            items: ["Active", "Suspended"],
            hint: "Update User Status",
          ),
          SizedBox(height: 16.h),
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
                    userController.isUpdating.value
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                          title: CommonCode().t(LocaleKeys.updateChanges),
                          onTap: () {
                            userController.updateUserInController(
                              userId: widget.user.id,
                              name: nameController.text,
                              mobile: mobileController.text,
                              email: emailController.text,
                              companyName: companyController.text,
                              status: widget.selectedStatus.value,
                            );
                            nameController.clear();
                            mobileController.clear();
                            emailController.clear();
                            companyController.clear();
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
