import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/custom_widgets/customDialog1.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/custom_widgets/custom_dialog.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'package:matloob_admin/models/store_model.dart';
import 'package:matloob_admin/screens/dashboard_screen/controller/dashboard_controller.dart';
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
  Store store;

  ViewStoreDetailModel({
    super.key,
    this.showEditApprove = false,
    this.onEdit,
    this.showStoreEdit = false,
    required this.selectedStatus,
    required this.store,
  });

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
    companyNameController = TextEditingController(
      text: widget.store.companyName,
    );
    contactNumberController = TextEditingController(
      text: widget.store.companyNumber,
    );
    locationController = TextEditingController(text: widget.store.location);
    controller.specialityController.value = widget.store.speciality;
  }

  Widget customTextField({
    required TextEditingController controller,
    String hintText = "",
    int maxLines = 1,
    bool readOnly = false,
    EdgeInsets contentPadding = const EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 20,
    ),
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
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

  @override
  Widget build(BuildContext context) {
    return CustomDialog1(
      width: 750.w,
      body: SingleChildScrollView(
        child: Column(
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
                    child: customTextField(
                      hintText: kCompanyName,
                      controller: companyNameController,
                      readOnly: true,
                    ),
                  ),
                ),
                SizedBox(width: 11.w),
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: customTextField(
                      hintText: kContactNumber,
                      controller: contactNumberController,
                      readOnly: true,
                    ),
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
                    child: customTextField(
                      hintText: kLocation,
                      controller: locationController,
                      readOnly: false,
                    ),
                  ),
                ),
                SizedBox(width: 11.w),
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: CustomDropdown(
                      selected: controller.specialityController,
                      items: ["Services", "Product", "Both"],
                      hint: kUpdateStoreStatus,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            Text(
              kUpdateStoreStatus,

              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8.h),
            CustomDropdown(
              selected: widget.selectedStatus,
              items: [
                "Pending",
                "Accepted",
                "RevisonRequested",
                "Rejected",
                "Completed",
                "Cancelled",
              ],
              hint: kUpdateStoreStatus,
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
                              title: kReject,
                              onTap: () {
                                final reasonController =
                                    TextEditingController();

                                Get.dialog(
                                  barrierDismissible: false,
                                  CustomDialog(
                                    image: kRejectReasonImage,
                                    title: kRejectionReason,
                                    btnText: kReject,
                                    isLoading: controller.isLoading3,
                                    onTap: () async {
                                      await controller.rejectStore(
                                        storeId: widget.store.id,
                                        reason: reasonController.text,
                                      );
                                      reasonController.clear();
                                      Get.back();
                                      showCustomSnackbar(
                                        "Success",
                                        "Store rejected successfully",
                                        backgroundColor: kGreenColor,
                                      );
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
                            title: kEdit,
                            onTap: () async {
                              final Map<String, dynamic> updateData = {
                                "companyName": companyNameController.text,
                                "companyNumber": contactNumberController.text,
                                "location": locationController.text,
                                "speciality":
                                    controller.specialityController.value,
                                "storeStatus": widget.selectedStatus.value,
                              };

                              await controller.updateStoreDetails(
                                storeId: widget.store.id,
                                updateData: updateData,
                              );
                              companyNameController.clear();
                              contactNumberController.clear();
                              locationController.clear();
                            },
                            height: 40.h,
                            width: 133.w,
                            color:
                                widget.showEditApprove
                                    ? kWhiteColor
                                    : kPrimaryColor,
                            borderRadius: 12,
                            borderColor:
                                widget.showEditApprove
                                    ? kBlackColor
                                    : kPrimaryColor,
                            textSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor:
                                widget.showEditApprove
                                    ? kBlackColor
                                    : kWhiteColor,
                          ),
                ),
                SizedBox(width: 16.w),
                if (widget.showEditApprove)
                  Obx(
                    () =>
                        controller.isLoading1.value
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                              title: kApprove,
                              onTap: () {
                                Get.dialog(
                                  barrierDismissible: false,
                                  CustomDialog(
                                    image: kApproveDialogImage,
                                    title: kApproveDetail,
                                    isLoading: controller.isLoading1,
                                    btnText: kApprove,
                                    onTap: () async {
                                      await controller.updateStoreStatusAction(
                                        storeId: widget.store.id,
                                        newStatus: "Accepted",
                                      );

                                      Get.back();
                                      showCustomSnackbar(
                                        "Success",
                                        "Store status updated to Accepted",
                                        backgroundColor: kGreenColor,
                                      );
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
