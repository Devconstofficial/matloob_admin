import 'dart:developer';
import 'dart:html' as html;

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/custom_widgets/customDialog1.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'package:matloob_admin/generated/locale_keys.g.dart';
import 'package:matloob_admin/screens/store_management/controller/store_controller.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import 'package:matloob_admin/utils/common_code.dart';
import 'package:matloob_admin/utils/image_picker_services.dart';

import '../models/rfq_categories_model.dart';
import '../models/rfq_sub_categories_model.dart';
import '../models/rfq_sub_sub_categories_model.dart';
import '../utils/app_colors.dart';
import 'custom_dropdown.dart';

class AddStoreDialog extends StatefulWidget {
  const AddStoreDialog({super.key});

  @override
  State<AddStoreDialog> createState() => _AddStoreDialogState();
}

class _AddStoreDialogState extends State<AddStoreDialog> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController companyContactController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  RxString speciality = ''.obs;
  RxString userId = ''.obs;
  Rx<Uint8List?> selectedLogoBytes = Rx<Uint8List?>(null);
  RxString logoUrl = ''.obs;

  StoreController storeController = Get.put(StoreController());

  Widget customTextField(TextEditingController controller, String hintText, {int maxLines = 1, IconData? prefixIcon, double? topPadding}) {
    return TextField(
      controller: controller,
      style: GoogleFonts.roboto(fontSize: 15.sp, fontWeight: FontWeight.w400, color: kBlackColor),
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: kBlackColor) : null,
        hintStyle: GoogleFonts.roboto(color: kBlackColor.withOpacity(0.5), fontWeight: FontWeight.w400, fontSize: 14.sp),
        hintText: hintText,
        contentPadding: EdgeInsets.only(top: topPadding ?? 0, bottom: 0, left: 20, right: 20),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: kBlackColor.withOpacity(0.1))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: kBlackColor.withOpacity(0.1))),
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
          Text(CommonCode().t(LocaleKeys.userDetails), style: AppStyles.blackTextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w300)),
          SizedBox(height: 13.h),
          Obx(() {
            final value = userId.value.isEmpty ? null : userId.value;
            return DropdownButtonFormField2<String>(
              value: value,
              isExpanded: true,
              dropdownStyleData: DropdownStyleData(maxHeight: 230, decoration: BoxDecoration(color: kWhiteColor, borderRadius: BorderRadius.circular(8.r))),
              hint: Text(
                CommonCode().t(LocaleKeys.selectUser),
                style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400, fontSize: 14.sp, color: kBlackColor.withOpacity(0.5)),
              ),
              style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: kBlackColor.withOpacity(0.5)),
              decoration: InputDecoration(
                filled: true,
                fillColor: kBlackShade1Color.withOpacity(0.01),
                contentPadding: EdgeInsets.only(right: 6.w, top: 15.h, bottom: 15.h),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: kBlackShade1Color.withOpacity(0.10))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: kBlackShade1Color.withOpacity(0.10))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: kBlackShade1Color.withOpacity(0.10))),
              ),
              items:
                  storeController.usersBasicList.map((user) {
                    return DropdownMenuItem<String>(
                      value: user['id'],
                      child: Text("Id: ${user['id']}, Name: ${user['name']}", style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400, fontSize: 14)),
                    );
                  }).toList(),
              onChanged: (val) {
                if (val != null) userId.value = val;
              },
            );
          }),
          SizedBox(height: 30.h),
          Text(kStoreDetails, style: AppStyles.blackTextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w300)),
          SizedBox(height: 13.h),

          Obx(
            () => Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    final input = html.FileUploadInputElement()..accept = 'image/*';
                    input.click();
                    input.onChange.listen((e) async {
                      final file = input.files?.first;
                      if (file != null) {
                        final reader = html.FileReader();
                        reader.readAsArrayBuffer(file);
                        reader.onLoadEnd.listen((e) {
                          selectedLogoBytes.value = reader.result as Uint8List?;
                        });
                      }
                    });
                  },
                  child: Container(
                    width: 150.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: selectedLogoBytes.value == null ? Border.all(color: kGreyColor1, width: 2, style: BorderStyle.solid) : null,
                      color: kBlackColor.withOpacity(0.05),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child:
                          selectedLogoBytes.value == null
                              ? Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.add_a_photo_outlined, size: 40.sp, color: kGreyColor1),
                                    SizedBox(height: 4.h),
                                    Text(CommonCode().t(LocaleKeys.addLogo), style: TextStyle(fontSize: 14.sp, color: kBlackColor.withOpacity(0.5))),
                                  ],
                                ),
                              )
                              : Image.memory(selectedLogoBytes.value!, fit: BoxFit.cover, width: 150.w, height: 150.h),
                    ),
                  ),
                ),
                if (selectedLogoBytes.value != null)
                  Positioned(
                    top: 6.h,
                    right: 6.w,
                    child: GestureDetector(
                      onTap: () {
                        selectedLogoBytes.value = null;
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.close, color: Colors.white, size: 16.sp),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 13.h),
          Row(
            children: [
              Expanded(child: SizedBox(height: 48.h, child: customTextField(companyNameController, CommonCode().t(LocaleKeys.companyName)))),
              SizedBox(width: 11.w),
              Expanded(child: SizedBox(height: 48.h, child: customTextField(companyContactController, CommonCode().t(LocaleKeys.companyNumber)))),
            ],
          ),
          SizedBox(height: 13.h),
          Row(
            children: [
              Expanded(child: SizedBox(height: 48.h, child: customTextField(locationController, CommonCode().t(LocaleKeys.location)))),
              SizedBox(width: 11.w),
              Expanded(
                child: SizedBox(
                  height: 60.h,
                  child: CustomDropdownWithModel<RfqCategoriesModel>(
                    selected: storeController.rfqSelectedCategoriesObj,
                    items: storeController.rfqCategoriesList,
                    hint: "Select Category",
                    itemLabel: (category) => (context.locale.languageCode == 'ar' ? category.arName : category.enName) ?? "",
                    onChanged: (value) async {
                      // Optional: Do something when selection changes

                      if (value != null) {
                        String? categoryName = context.locale.languageCode == 'ar' ? value.arName : value.enName;

                        bool hasData = await storeController.getRfqSubCategories(
                          categoryId: value.id!,
                          isFromDropDown: true,
                          previousCategory: storeController.rfqSelectedCategoriesObj.value,
                        );
                        if (hasData) {
                          storeController.rfqSelectedCategory.value = categoryName ?? '';
                          storeController.rfqSelectedCategoryId.value = value.id ?? '';
                          storeController.rfqSelectedCategoriesObj.value = value;
                        }
                      }
                    },
                  ),
                ),
              ),
              // Expanded(child: SizedBox(height: 48.h, child: CustomDropdown(selected: speciality, items: ["Services", "Product", "Both"], hint: kSpecialty))),
            ],
          ),

          SizedBox(height: 13.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 60.h,
                  child: CustomDropdownWithModel<RfqSubCategoriesModel>(
                    selected: storeController.rfqSelectedSubCategoriesObj,
                    items: storeController.rfqSubcategoriesList,
                    hint: "Select Sub Category",
                    itemLabel: (category) => (context.locale.languageCode == 'ar' ? category.arName : category.enName) ?? "",
                    onChanged: (value) async {
                      // Optional: Do something when selection changes

                      if (value != null) {
                        String? categoryName = context.locale.languageCode == 'ar' ? value.arName : value.enName;

                        bool hasData = await storeController.getRfqSubSubCategories(categoryId: value.categoryId!, subCategoryId: value.id!, isFromDropDown: true);
                        if (hasData) {
                          storeController.rfqSelectedCategory.value = categoryName ?? '';
                          storeController.rfqSelectedSubCategoryId.value = value.id ?? '';

                          storeController.rfqSelectedSubCategoriesObj.value = value;
                        }
                        print("Selected: ${value.id} - $categoryName");
                      }
                    },
                  ),
                ),
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: SizedBox(
                  height: 60.h,
                  child: CustomDropdownWithModel<RfqSubSubCategoriesModel>(
                    selected: storeController.rfqSelectedSubSubCategoriesObj,
                    items: storeController.rfqSubSubcategoriesModelList,
                    hint: "Select Sub SubCategory",
                    itemLabel: (category) => (context.locale.languageCode == 'ar' ? category.arName : category.enName) ?? "",
                    onChanged: (value) {
                      // Optional: Do something when selection changes

                      if (value != null) {
                        String? categoryName = context.locale.languageCode == 'ar' ? value.arName : value.enName;

                        storeController.rfqSelectedSubCategory.value = categoryName ?? '';
                        storeController.rfqSelectedSubSubCategoryId.value = value.id ?? '';
                        storeController.rfqSelectedSubSubCategoriesObj.value = value;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 13.h),
          Row(children: [Expanded(child: customTextField(bioController, CommonCode().t(LocaleKeys.companyBio), maxLines: 5, topPadding: 20))]),
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
                    storeController.isAdding.value
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                          title: CommonCode().t(LocaleKeys.addStore),
                          onTap: () async {
                            if (userId.value.isEmpty ||
                                selectedLogoBytes.value == null ||
                                companyNameController.text.isEmpty ||
                                locationController.text.isEmpty ||
                                storeController.rfqSelectedCategoryId.value.isEmpty ||
                                storeController.rfqSelectedSubCategoryId.value.isEmpty ||
                                storeController.rfqSelectedSubSubCategoryId.value.isEmpty) {
                              showCustomSnackbar("Error", "Please fill all fields and select a logo");
                              return;
                            }

                            storeController.isAdding.value = true;

                            try {
                              final extension = "png";
                              final uploadedUrl = await ImagePickerService().uploadImageToFirebase(selectedLogoBytes.value!, extension);

                              if (uploadedUrl.isEmpty) {
                                showCustomSnackbar("Error", "Failed to upload logo");
                                storeController.isAdding.value = false;
                                return;
                              }
                              speciality.value = 'Both';
                              await storeController.createStore(
                                userId: userId.value,
                                logo: uploadedUrl,
                                companyName: companyNameController.text,
                                bio: bioController.text,
                                companyNumber: companyContactController.text,
                                location: locationController.text,
                                speciality: speciality.value,
                                storeStatus: 'Accepted',
                                categoryId: storeController.rfqSelectedCategoryId.value,
                                subcategoryId: storeController.rfqSelectedSubCategoryId.value,
                                subSubcategoryId: storeController.rfqSelectedSubSubCategoryId.value,
                              );
                            } catch (e) {
                              log("Error creating store: $e");
                              showCustomSnackbar("Error", "Failed to create store");
                            } finally {
                              storeController.isAdding.value = false;
                            }
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
