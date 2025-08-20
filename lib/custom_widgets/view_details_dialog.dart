import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/custom_widgets/customDialog1.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/custom_widgets/custom_dialog.dart';
import 'package:matloob_admin/screens/auth/controller/auth_controller.dart';
import 'package:matloob_admin/utils/app_images.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import '../utils/app_colors.dart';

class ViewDetailModel extends StatefulWidget {
  const ViewDetailModel({
    super.key,
  });

  @override
  State<ViewDetailModel> createState() => _ViewDetailModelState();
}

class _ViewDetailModelState extends State<ViewDetailModel> {
  customTextField(
    hintText, {
    int maxLines = 1,
    EdgeInsets contentPadding = const EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 20,
    ),
  }) {
    return TextField(
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
        contentPadding: contentPadding,
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
      width: 750.w,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              kRFQInformation,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          SizedBox(height: 11.h),
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(kPersonImage, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                "Ahmed Al-Mutairi",
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          SizedBox(height: 44.h, child: customTextField(kRFQInformationDetail)),
          SizedBox(height: 16.h),
          customContainer(title: "Delivery", detail: "Yes", isColored: true),
          SizedBox(height: 16.h),
          customContainer(
            title: kLocation,
            detail: "Mecca, Al Hamra and Umm Al Jud",
          ),
          SizedBox(height: 16.h),
          customContainer(title: kCondition, detail: "New", isColored: true),
          SizedBox(height: 16.h),
          customContainer(title: kTargetedPrice, detail: "500 SAR"),
          SizedBox(height: 16.h),

          Text(
            kTitle,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: 44.h,
            child: customTextField(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod ",
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            kProjectDescription,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 8.h),
          customTextField(
            kProjectDescriptionHint,
            maxLines: 6,
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          ),

          SizedBox(height: 32.h),
          Row(
            children: [
              CustomButton(
                title: kReject,
                onTap: () {
                  Get.dialog(
                    CustomDialog(
                      image: kRejectReasonImage,
                      title: kRejectionReason,
                      btnText: kReject,
                      onTap: () {
                        Get.back();
                      },
                      hideDetail: true,
                      showRejection: true,
                      btnColor: kRedColor,
                    ),
                  );
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

              Spacer(),

              CustomButton(
                title: kEdit,
                onTap: () {},
                height: 40.h,
                width: 133.w,
                color: kWhiteColor,
                borderRadius: 12,
                borderColor: kBlackColor,
                textSize: 14,
                fontWeight: FontWeight.w400,
                textColor: kBlackColor,
              ),

              SizedBox(width: 16.w),
              CustomButton(
                title: kApprove,
                onTap: () {
                  Get.back();
                },
                height: 40.h,
                width: 140.w,
                borderRadius: 12,
                textSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
