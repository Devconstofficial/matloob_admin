import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/custom_widgets/customDialog1.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/custom_widgets/custom_dialog.dart';
import 'package:matloob_admin/screens/auth/controller/auth_controller.dart';
import 'package:matloob_admin/utils/app_images.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';

import '../utils/app_colors.dart';
import 'custom_dropdown.dart';

class ViewStoreDetailModel extends StatefulWidget {
  bool showEditApprove;
  bool showStoreEdit;
  VoidCallback? onEdit;
  RxString selectedStatus;

  ViewStoreDetailModel({
    super.key,
    this.showEditApprove = false,
    this.onEdit,
    this.showStoreEdit = false,
    required this.selectedStatus,
  });

  @override
  State<ViewStoreDetailModel> createState() => _ViewStoreDetailModelState();
}

class _ViewStoreDetailModelState extends State<ViewStoreDetailModel> {
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

  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return CustomDialog1(
      width: 750.w,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kStoreDetails,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 11.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(kCompanyName),
                ),
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(kContactNumber),
                ),
              ),
            ],
          ),
          SizedBox(height: 11.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(kLocation),
                ),
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(kSpecialty),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          if (widget.showStoreEdit != true) ...[
            Text(
              kProductInformation,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                CustomButton(
                  title: kDentalClinics,
                  onTap: () {},
                  height: 28.h,
                  width: 106.w,
                  color: kGreyShade9Color,
                  borderRadius: 8,
                  borderColor: kGreyShade9Color,
                  textSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: kGreyColor6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 24,
                    color: kGreyShade10Color,
                  ),
                ),
                CustomButton(
                  title: kDentalBurs,
                  onTap: () {},
                  height: 28.h,
                  width: 96.w,
                  color: kGreyShade9Color,
                  borderRadius: 8,
                  borderColor: kGreyShade9Color,
                  textSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: kGreyColor6,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: customTextField(kBrandName),
                  ),
                ),
                SizedBox(width: 11.w),
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: customTextField(kManufacturingCountry),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  kContactForPrice,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Obx(
                  () => FlutterSwitch(
                    width: 42.0.w,
                    height: 26.0.h,
                    toggleSize: 15.0.w,
                    value: controller.isNotificationsOn.value,
                    activeColor: kPrimaryColor,
                    inactiveColor: kGreyColor2,
                    onToggle: (val) {
                      controller.isNotificationsOn.value = val;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 48.h,
              child: customTextField(kContactForPriceHint),
            ),
            SizedBox(height: 16.h),
          ],

          Text(
            kProductImages,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),

          SizedBox(height: 8.h),

          Row(
            spacing: 20,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(kProductImage, height: 75, width: 100),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(kProductImage, height: 75, width: 100),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(kProductImage, height: 75, width: 100),
              ),
            ],
          ),

          SizedBox(height: 15.h),

          Text(
            widget.showStoreEdit == true
                ? kUpdateStoreStatus
                : kProjectDescription,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 8.h),
          widget.showStoreEdit == true
              ? CustomDropdown(
                selected: widget.selectedStatus,
                items: [kActive, kPending, kRestricted],
                hint: kUpdateStoreStatus,
              )
              : customTextField(
                kProjectDescriptionHint,
                maxLines: 6,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
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
              if (widget.showEditApprove == true && widget.showStoreEdit != true)
                CustomButton(
                  title: kEdit,
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        widget.showEditApprove = false;
                      });
                    }
                  },
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
              widget.showStoreEdit == true
                  ? CustomButton(
                    title: kApplyChanges,
                    onTap: () {
                      Get.back();
                    },
                    height: 40.h,
                    width: 140.w,
                    borderRadius: 12,
                    textSize: 14,
                    fontWeight: FontWeight.w400,
                  )
                  : CustomButton(
                    title:
                        widget.showEditApprove == true
                            ? kApprove
                            : kEditApprove,
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
