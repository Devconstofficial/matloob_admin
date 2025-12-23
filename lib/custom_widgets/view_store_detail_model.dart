import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/custom_widgets/customDialog1.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/custom_widgets/custom_dialog.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'package:matloob_admin/generated/locale_keys.g.dart';
import 'package:matloob_admin/models/store_model.dart';
import 'package:matloob_admin/screens/dashboard_screen/controller/dashboard_controller.dart';
import 'package:matloob_admin/utils/app_images.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import 'package:matloob_admin/utils/common_code.dart';

import '../models/rfq_categories_model.dart';
import '../models/rfq_sub_categories_model.dart';
import '../models/rfq_sub_sub_categories_model.dart';
import '../utils/app_colors.dart';
import 'custom_dropdown.dart';

class ViewStoreDetailModel extends StatefulWidget {
  bool showEditApprove;
  bool showStoreEdit;
  VoidCallback? onEdit;
  RxString selectedStatus;
  Store store;

  ViewStoreDetailModel({super.key, this.showEditApprove = false, this.onEdit, this.showStoreEdit = false, required this.selectedStatus, required this.store});

  @override
  State<ViewStoreDetailModel> createState() => _ViewStoreDetailModelState();
}

class _ViewStoreDetailModelState extends State<ViewStoreDetailModel> {
  late TextEditingController companyNameController;
  late TextEditingController contactNumberController;
  late TextEditingController locationController;

  DashboardController controller = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    companyNameController = TextEditingController(text: widget.store.companyName);
    contactNumberController = TextEditingController(text: widget.store.companyNumber);
    locationController = TextEditingController(text: widget.store.location);
    controller.specialityController.value = CommonCode().isEnglish(widget.store.speciality) ? widget.store.speciality.toTitleCase() : widget.store.speciality;
    controller.getRfqCategories();
    controller.rfqSelectedCategory.value = widget.store.category is String ? widget.store.category : widget.store.category.arName;
    controller.rfqSelectedCategoriesObj.value = widget.store.category;

    controller.rfqSelectedSubCategory.value = widget.store.subcategory is String ? widget.store.subcategory : widget.store.subcategory.arName;
    controller.rfqSelectedSubCategoriesObj.value = widget.store.subcategory;
    controller.getRfqSubCategories(categoryId: widget.store.category.id, isFromDropDown: true, isEdit: true);

    controller.rfqSelectedSubSubCategory.value = widget.store.subSubcategory is String ? widget.store.subSubcategory : widget.store.subSubcategory.arName;
    controller.rfqSelectedSubSubCategoriesObj.value = widget.store.subSubcategory;
    controller.getRfqSubSubCategories(subCategoryId: widget.store.subcategory.id, categoryId: widget.store.category.id, isFromDropDown: true, isEdit: true);
  }

  Widget customTextField({
    required TextEditingController controller,
    String hintText = "",
    int maxLines = 1,
    bool readOnly = false,
    EdgeInsets contentPadding = const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      style: GoogleFonts.roboto(fontSize: 15.sp, fontWeight: FontWeight.w400, color: kBlackColor),
      maxLines: maxLines,
      decoration: InputDecoration(
        hintStyle: GoogleFonts.roboto(color: kBlackColor.withOpacity(0.5), fontWeight: FontWeight.w400, fontSize: 14.sp),
        hintText: hintText,
        contentPadding: contentPadding,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: kBlackColor.withOpacity(0.1))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: kBlackColor.withOpacity(0.1))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog1(
      width: 750.w,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(CommonCode().t(LocaleKeys.storeDetails), style: AppStyles.blackTextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w300)),
            SizedBox(height: 11.h),
            Row(
              children: [
                Expanded(child: SizedBox(height: 48.h, child: customTextField(hintText: kCompanyName, controller: companyNameController, readOnly: true))),
                SizedBox(width: 11.w),
                Expanded(child: SizedBox(height: 48.h, child: customTextField(hintText: kContactNumber, controller: contactNumberController, readOnly: true))),
              ],
            ),
            /*SizedBox(height: 11.h),
            Row(
              children: [
                Expanded(child: SizedBox(height: 48.h, child: customTextField(hintText: CommonCode().t(LocaleKeys.location), controller: locationController, readOnly: false))),
                SizedBox(width: 11.w),
                Expanded(
                  child: SizedBox(
                    height: 56.h,
                    child: CustomDropdown(
                      selected: controller.specialityController,
                      items: CommonCode().isEnglish(controller.specialityController.value) ? ["Services", "Product", "Both"] : ["الخدمات", "المنتج", "كلاهما"],
                      hint: CommonCode().t(LocaleKeys.updateStoreStatus),
                    ),
                  ),
                ),
              ],
            ),*/
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(child: SizedBox(height: 48.h, child: customTextField(hintText: CommonCode().t(LocaleKeys.location), controller: locationController, readOnly: false))),
                SizedBox(width: 11.w),
                Expanded(
                  child: SizedBox(
                    height: 56.h,
                    child: CustomDropdownWithModel<RfqCategoriesModel>(
                      selected: controller.rfqSelectedCategoriesObj,
                      items: controller.rfqCategoriesList,
                      hint: "",
                      itemLabel: (category) => (context.locale.languageCode == 'ar' ? category.arName : category.enName) ?? "",
                      onChanged: (value) async {
                        // Optional: Do something when selection changes

                        if (value != null) {
                          String? categoryName = context.locale.languageCode == 'ar' ? value.arName : value.enName;

                          bool hasData = await controller.getRfqSubCategories(
                            categoryId: value.id!,
                            isFromDropDown: true,
                            previousCategory: controller.rfqSelectedCategoriesObj.value,
                          );
                          if (hasData) {
                            controller.rfqSelectedCategory.value = categoryName ?? '';
                            controller.rfqSelectedCategoryId.value = value.id ?? '';
                            controller.rfqSelectedCategoriesObj.value = value;
                          }
                        }
                      },
                    ),
                  ),
                ) /*Expanded(
                  child: SizedBox(
                    height: 56.h,
                    child: CustomDropdown(
                      selected: controller.specialityController,
                      items: CommonCode().isEnglish(controller.specialityController.value) ? ["Services", "Product", "Both"] : ["الخدمات", "المنتج", "كلاهما"],
                      hint: CommonCode().t(LocaleKeys.updateStoreStatus),
                    ),
                  ),
                ),*/,
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56.h,
                    child: CustomDropdownWithModel<RfqSubCategoriesModel>(
                      selected: controller.rfqSelectedSubCategoriesObj,
                      items: controller.rfqSubcategoriesList,
                      hint: "Select Category",
                      itemLabel: (category) => (context.locale.languageCode == 'ar' ? category.arName : category.enName) ?? "",
                      onChanged: (value) async {
                        // Optional: Do something when selection changes

                        if (value != null) {
                          String? categoryName = context.locale.languageCode == 'ar' ? value.arName : value.enName;

                          bool hasData = await controller.getRfqSubSubCategories(categoryId: value.categoryId!, subCategoryId: value.id!, isFromDropDown: true);
                          if (hasData) {
                            controller.rfqSelectedCategory.value = categoryName ?? '';
                            controller.rfqSelectedSubCategoryId.value = value.id ?? '';

                            controller.rfqSelectedSubCategoriesObj.value = value;
                          }
                          print("Selected: ${value.id} - ${categoryName}");
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(width: 11.w),
                Expanded(
                  child: SizedBox(
                    height: 56.h,
                    child: CustomDropdownWithModel<RfqSubSubCategoriesModel>(
                      selected: controller.rfqSelectedSubSubCategoriesObj,
                      items: controller.rfqSubSubcategoriesModelList,
                      hint: "Select Category",
                      itemLabel: (category) => (context.locale.languageCode == 'ar' ? category.arName : category.enName) ?? "",
                      onChanged: (value) {
                        // Optional: Do something when selection changes

                        if (value != null) {
                          String? categoryName = context.locale.languageCode == 'ar' ? value.arName : value.enName;

                          controller.rfqSelectedSubCategory.value = categoryName ?? '';
                          controller.rfqSelectedSubSubCategoryId.value = value.id ?? '';
                          controller.rfqSelectedSubSubCategoriesObj.value = value;
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            Text(CommonCode().t(LocaleKeys.updateStoreStatus), style: AppStyles.blackTextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w300)),
            SizedBox(height: 8.h),
            CustomDropdown(
              selected: widget.selectedStatus,
              items: ["Pending", "Accepted", "RevisonRequested", "Rejected", "Completed", "Cancelled"],
              hint: CommonCode().t(LocaleKeys.updateStoreStatus),
            ),

            SizedBox(height: 32.h),
            Row(
              children: [
                if (widget.showEditApprove)
                  Obx(
                    () =>
                        controller.isLoading3.value
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                              title: CommonCode().t(LocaleKeys.reject),
                              onTap: () {
                                final reasonController = TextEditingController();

                                Get.dialog(
                                  barrierDismissible: false,
                                  CustomDialog(
                                    image: kRejectReasonImage,
                                    title: CommonCode().t(LocaleKeys.rejectionReason),
                                    btnText: CommonCode().t(LocaleKeys.reject),
                                    isLoading: controller.isLoading3,
                                    onTap: () async {
                                      await controller.rejectStore(storeId: widget.store.id, reason: reasonController.text);
                                      reasonController.clear();
                                      Get.back();
                                      showCustomSnackbar("Success", "Store rejected successfully", backgroundColor: kGreenColor);
                                    },
                                    hideDetail: true,
                                    showRejection: true,
                                    btnColor: kRedColor,

                                    reasonController: reasonController,
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
                  ),
                Spacer(),

                Obx(
                  () =>
                      controller.isLoading2.value
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                            title: CommonCode().t(LocaleKeys.update),
                            onTap: () async {
                              if (controller.rfqSelectedSubCategoryId.value.isEmpty || controller.rfqSelectedSubSubCategoryId.value.isEmpty) {
                                showCustomSnackbar("Error", "Sub Category and sub sub category not selected");
                                return;
                              }
                              final Map<String, dynamic> updateData = {
                                "companyName": companyNameController.text,
                                "companyNumber": contactNumberController.text,
                                "location": locationController.text,
                                "speciality": controller.specialityController.value,
                                "storeStatus": widget.selectedStatus.value,

                                "categoryId": controller.rfqSelectedCategoryId.value,
                                "subcategoryId": controller.rfqSelectedSubCategoryId.value,
                                "subSubcategoryId": controller.rfqSelectedSubSubCategoryId.value,
                              };

                              await controller.updateStoreDetails(storeId: widget.store.id, updateData: updateData);
                              companyNameController.clear();
                              contactNumberController.clear();
                              locationController.clear();
                            },
                            height: 40.h,
                            width: 133.w,
                            color: widget.showEditApprove ? kWhiteColor : kPrimaryColor,
                            borderRadius: 12,
                            borderColor: widget.showEditApprove ? kBlackColor : kPrimaryColor,
                            textSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: widget.showEditApprove ? kBlackColor : kWhiteColor,
                          ),
                ),
                SizedBox(width: 16.w),
                if (widget.showEditApprove)
                  Obx(
                    () =>
                        controller.isLoading1.value
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                              title: CommonCode().t(LocaleKeys.approve),
                              onTap: () {
                                Get.dialog(
                                  barrierDismissible: false,
                                  CustomDialog(
                                    image: kApproveDialogImage,
                                    title: kApproveDetail,
                                    isLoading: controller.isLoading1,
                                    btnText: kApprove,
                                    onTap: () async {
                                      await controller.updateStoreStatusAction(storeId: widget.store.id, newStatus: "Accepted");

                                      Get.back();
                                      showCustomSnackbar("Success", "Store status updated to Accepted", backgroundColor: kGreenColor);
                                    },
                                    hideDetail: true,
                                  ),
                                );
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
      ),
    );
  }
}
