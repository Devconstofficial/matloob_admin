import 'dart:io' as io;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matloob_admin/custom_widgets/customDialog1.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/screens/auth/controller/auth_controller.dart';
import 'package:matloob_admin/utils/app_images.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';

import '../utils/app_colors.dart';
import 'custom_dropdown.dart';

class AddStoreModel extends StatefulWidget {
  RxString selectedCountry;

  AddStoreModel({super.key, required this.selectedCountry});

  @override
  State<AddStoreModel> createState() => _AddStoreModelState();
}

class _AddStoreModelState extends State<AddStoreModel> {
  List<XFile> selectedImages = [];

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
            kEnterStoreDetails,
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
                child: CustomDropdown(
                  selected: widget.selectedCountry,
                  items: [kServices, kProduct, kBoth],
                  hint: kSpecialty,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            kCatalogDetails,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 16.h),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => controller.selectedTab.value = 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        kMedicalProducts,
                        style: AppStyles.blackTextStyle().copyWith(
                          color:
                              controller.selectedTab.value == 0
                                  ? kPrimaryColor
                                  : Colors.grey,
                          fontSize: 14.sp,
                          fontWeight:
                              controller.selectedTab.value == 0
                                  ? FontWeight.w400
                                  : FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        height: 2.h,
                        width: 110.w,
                        color:
                            controller.selectedTab.value == 0
                                ? kPrimaryColor
                                : kWhiteColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                GestureDetector(
                  onTap: () => controller.selectedTab.value = 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        kMedicalServices,
                        style: AppStyles.blackTextStyle().copyWith(
                          color:
                              controller.selectedTab.value == 1
                                  ? kPrimaryColor
                                  : Colors.grey,
                          fontSize: 14.sp,
                          fontWeight:
                              controller.selectedTab.value == 1
                                  ? FontWeight.w400
                                  : FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        height: 2.h,
                        width: 110.w,
                        color:
                            controller.selectedTab.value == 1
                                ? kPrimaryColor
                                : kWhiteColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                GestureDetector(
                  onTap: () => controller.selectedTab.value = 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        kLaboratoriesEquipment,
                        style: AppStyles.blackTextStyle().copyWith(
                          color:
                              controller.selectedTab.value == 2
                                  ? kPrimaryColor
                                  : Colors.grey,
                          fontSize: 14.sp,
                          fontWeight:
                              controller.selectedTab.value == 2
                                  ? FontWeight.w400
                                  : FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        height: 2.h,
                        width: 110.w,
                        color:
                            controller.selectedTab.value == 2
                                ? kPrimaryColor
                                : kWhiteColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Obx(() {
            final chipRows =
                controller.selectedTab.value == 0
                    ? controller.medicalProd
                    : controller.selectedTab.value == 1
                    ? controller.medServices
                    : controller.labEqu;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(chipRows.length, (rowIndex) {
                return Container(
                  margin: EdgeInsets.only(bottom: 13.h),
                  height: 35.h,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:
                            chipRows[rowIndex].map((label) {
                              final isSelected = controller.selectedChips
                                  .contains(label);
                              return Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: ChoiceChip(
                                  label: Text(
                                    label,
                                    textAlign: TextAlign.center,
                                    style: AppStyles.whiteTextStyle().copyWith(
                                      color:
                                          isSelected
                                              ? kWhiteColor
                                              : kBlackShade1Color,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  labelPadding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                  ),
                                  selected: isSelected,
                                  selectedColor: kPrimaryColor,
                                  backgroundColor: kGreyShade9Color,
                                  onSelected:
                                      (_) => controller.toggleChip(label),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    side: BorderSide(
                                      color:
                                          isSelected
                                              ? kPrimaryColor
                                              : kGreyShade9Color,
                                    ),
                                  ),
                                  showCheckmark: false,
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
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

          SizedBox(height: 48.h, child: customTextField(kContactForPriceHint)),

          SizedBox(height: 16.h),
          Text(
            kProductImages,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),

          SizedBox(height: 8.h),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            dashPattern: [12, 8],
            color: kPrimaryColor,
            strokeWidth: 0.8,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final List<XFile>? images = await picker.pickMultiImage();

                  if (images != null && images.isNotEmpty) {
                    setState(() {
                      selectedImages.addAll(images);
                    });
                  }
                },
                child: Container(
                  height: 144,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Image.asset(kUploadImage, height: 36, width: 36),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              kDragBrowse,
                              style: AppStyles.blackTextStyle().copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              kBrowse,
                              style: AppStyles.primaryTextStyle().copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          kMaxAllowed,
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kGreyColor7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          if (selectedImages.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 16),
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedImages.length,
                itemBuilder: (context, index) {
                  final image = selectedImages[index];
                  return Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: kIsWeb
                              ? Image.network(image.path, fit: BoxFit.cover)
                              : Image.file(io.File(image.path), fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: 4,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImages.removeAt(index);
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(4)
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  size: 12,
                                  color: kBlackColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

          SizedBox(height: 15.h),

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
                title: kCancel,
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
              Spacer(),
              CustomButton(
                title: kAddMoreProduct,
                onTap: () {},
                height: 40.h,
                width: 180.w,
                color: kWhiteColor,
                borderRadius: 12,
                borderColor: kBlackColor,
                textSize: 14,
                fontWeight: FontWeight.w400,
                textColor: kBlackColor,
              ),
              SizedBox(width: 20.w),
              CustomButton(
                title: kCreateStore,
                onTap: () {
                  Get.back();
                },
                height: 40.h,
                width: 150.w,
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
