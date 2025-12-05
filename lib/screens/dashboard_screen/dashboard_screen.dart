import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/custom_widgets/column_row.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'package:matloob_admin/custom_widgets/view_details_dialog.dart';
import 'package:matloob_admin/generated/locale_keys.g.dart';
import 'package:matloob_admin/models/rfq_model.dart';
import 'package:matloob_admin/models/store_model.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import 'package:matloob_admin/utils/common_code.dart';

import '../../../utils/app_images.dart';
import '../../custom_widgets/custom_dialog.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/view_store_detail_model.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  insightContainer(String img, String title, String detail, Color color) {
    return Container(
      width: 180.w,
      height: 94.h,
      decoration: BoxDecoration(color: kWhiteColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: kBlackColor.withOpacity(0.1))),
      child: Padding(
        padding: EdgeInsets.only(left: 21.w, right: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              spacing: 4.w,
              children: [
                Container(
                  height: 42.h,
                  width: 42.w,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                  child: Center(child: SvgPicture.asset(img, height: 22.h, width: 22.w, color: kWhiteColor)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6.h,
                    children: [
                      Text(title, style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w500, fontSize: 19.sp)),
                      Text(
                        detail,
                        style: AppStyles.blackTextStyle().copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 13.sp,
                          color: kBlackShade7Color.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SideMenu(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 40.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customHeader(CommonCode().t(LocaleKeys.dashboard), context),
                      Wrap(
                        spacing: 15.w,
                        runSpacing: 15.w,
                        children: [
                          Obx(
                            () => insightContainer(
                              kDoubleUserIcon,
                              controller.totalUsers.value.toString(),
                              CommonCode().t(LocaleKeys.totalUsers),
                              kGreenColor,
                            ),
                          ),
                          Obx(
                            () => insightContainer(
                              kAddStoreIcon,
                              controller.totalStores.value.toString(),
                              CommonCode().t(LocaleKeys.totalStores),
                              kPrimaryColor,
                            ),
                          ),
                          Obx(
                            () => insightContainer(
                              kAddStoreIcon,
                              controller.totalPendingStores.value.toString(),
                              CommonCode().t(LocaleKeys.pendingStores),
                              kGreenColor,
                            ),
                          ),
                          Obx(
                            () => insightContainer(
                              kAddStoreIcon,
                              controller.totalActiveStores.value.toString(),
                              CommonCode().t(LocaleKeys.liveStores),
                              kPrimaryColor,
                            ),
                          ),
                          Obx(
                            () => insightContainer(
                              kAddRfqIcon,
                              controller.totalRfqs.value.toString(),
                              CommonCode().t(LocaleKeys.totalRFQs),
                              kGreenColor,
                            ),
                          ),
                          Obx(
                            () => insightContainer(
                              kAddRfqIcon,
                              controller.totalPendingRfqs.value.toString(),
                              CommonCode().t(LocaleKeys.pendingRFQs),
                              kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            CommonCode().t(LocaleKeys.pendingStoreRequests),
                            style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w500, fontSize: 18.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: kGreyColor, width: 0.3)),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Stack(
                            children: [
                              Container(
                                height: 44,
                                decoration: BoxDecoration(color: kLightBlueColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                              ),
                              SizedBox(
                                width: Get.width,
                                child: Obx(() {
                                  if (controller.storeRequests.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 70),
                                        child: Text(
                                          "No new requests for stores",
                                          style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: kGreyColor),
                                        ),
                                      ),
                                    );
                                  }

                                  return DataTable(
                                    columnSpacing: 0,
                                    headingRowHeight: 44,
                                    dataRowMinHeight: 55,
                                    dataRowMaxHeight: 55,
                                    dividerThickness: 0.2,
                                    columns: [
                                      DataColumn(label: ColumnRowWidget(title: "Company Name")),
                                      DataColumn(label: ColumnRowWidget(title: "Company Number")),
                                      DataColumn(label: ColumnRowWidget(title: "Location")),
                                      DataColumn(label: ColumnRowWidget(title: "Speciality")),

                                      DataColumn(
                                        headingRowAlignment: MainAxisAlignment.center,
                                        label: Flexible(
                                          child: Text(
                                            "Action",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: controller.storeRequests.map((store) => _buildStoreDataRow(store, context)).toList(),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Text(
                            CommonCode().t(LocaleKeys.pendingRFQs),
                            style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w500, fontSize: 18.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: kGreyColor, width: 0.3)),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Stack(
                            children: [
                              Container(
                                height: 44,
                                decoration: BoxDecoration(color: kLightBlueColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                              ),
                              SizedBox(
                                width: Get.width,
                                child: Obx(() {
                                  if (controller.rfqs.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 70),
                                        child: Text(
                                          "No new RFQ requests",
                                          style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: kGreyColor),
                                        ),
                                      ),
                                    );
                                  }

                                  return DataTable(
                                    columnSpacing: 0,
                                    headingRowHeight: 44,
                                    dataRowMinHeight: 55,
                                    dataRowMaxHeight: 55,
                                    dividerThickness: 0.2,
                                    columns: [
                                      DataColumn(label: ColumnRowWidget(title: CommonCode().t(LocaleKeys.rfqId))),
                                      DataColumn(label: ColumnRowWidget(title: CommonCode().t(LocaleKeys.submittedBy))),
                                      DataColumn(label: ColumnRowWidget(title: CommonCode().t(LocaleKeys.category))),
                                      DataColumn(label: ColumnRowWidget(title: CommonCode().t(LocaleKeys.city))),
                                      DataColumn(
                                        headingRowAlignment: MainAxisAlignment.center,
                                        label: ColumnRowWidget(title: CommonCode().t(LocaleKeys.action)),
                                      ),
                                    ],
                                    rows: controller.rfqs.map((rfq) => _buildRfqDataRow(rfq, context)).toList(),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildStoreDataRow(Store store, context) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            store.companyName,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp, fontWeight: FontWeight.w200, color: kBlackShade7Color.withOpacity(0.7)),
          ),
        ),
        DataCell(
          Text(
            store.companyNumber,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp, fontWeight: FontWeight.w200, color: kBlackShade7Color.withOpacity(0.7)),
          ),
        ),
        DataCell(
          Text(
            store.location,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp, fontWeight: FontWeight.w200, color: kBlackShade7Color.withOpacity(0.7)),
          ),
        ),
        DataCell(
          Text(
            store.speciality,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp, fontWeight: FontWeight.w200, color: kBlackShade7Color.withOpacity(0.7)),
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    controller.selectedCountry.value = store.storeStatus.name;
                    controller.specialityController.value =
                        CommonCode().isEnglish(store.speciality) ? store.speciality.toTitleCase() : store.speciality;
                    Get.dialog(
                      barrierDismissible: false,
                      ViewStoreDetailModel(showEditApprove: true, onEdit: () {}, selectedStatus: controller.selectedCountry, store: store),
                    );
                  },
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: kPrimaryColor,
                    child: Center(child: SvgPicture.asset(kEditIcon, height: 16.h, width: 16.w)),
                  ),
                ),
              ),
              Obx(
                () =>
                    controller.isLoading3.value
                        ? const Center(child: CircularProgressIndicator())
                        : MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Get.dialog(
                                barrierDismissible: false,
                                CustomDialog(
                                  image: kRejectReasonImage,
                                  title: kRejectionReason,
                                  btnText: kReject,
                                  isLoading: controller.isLoading3,
                                  onTap: () async {
                                    await controller.rejectStore(storeId: store.id);
                                    showCustomSnackbar("Success", "Store rejected successfully", backgroundColor: kGreenColor);
                                  },
                                  hideDetail: true,
                                  showRejection: true,
                                  btnColor: kRedColor,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: kPrimaryColor,
                              child: Center(child: Icon(Icons.close, color: kWhiteColor, size: 14)),
                            ),
                          ),
                        ),
              ),
              Obx(
                () =>
                    controller.isLoading1.value
                        ? const Center(child: CircularProgressIndicator())
                        : MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Get.dialog(
                                barrierDismissible: false,
                                CustomDialog(
                                  image: kApproveDialogImage,
                                  title: kApproveDetail,
                                  isLoading: controller.isLoading1,
                                  btnText: kApprove,
                                  onTap: () async {
                                    await controller.updateStoreStatusAction(storeId: store.id, newStatus: "Accepted");

                                    showCustomSnackbar("Success", "Store status updated to Accepted", backgroundColor: kGreenColor);
                                  },
                                  hideDetail: true,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: kPrimaryColor,
                              child: Center(child: SvgPicture.asset(kCheckIcon, height: 16.h, width: 16.w)),
                            ),
                          ),
                        ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  DataRow _buildRfqDataRow(RfqModel rfq, context) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            rfq.rfqId,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp, fontWeight: FontWeight.w200, color: kBlackShade7Color.withOpacity(0.7)),
          ),
        ),
        DataCell(
          Text(
            rfq.user?.name ?? "",
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp, fontWeight: FontWeight.w200, color: kBlackShade7Color.withOpacity(0.7)),
          ),
        ),
        DataCell(
          Text(
            rfq.category == null
                ? ''
                : rfq.category is String
                ? rfq.category
                : Get.locale?.languageCode == 'ar'
                ? rfq.category.arName
                : rfq.category.enName,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp, fontWeight: FontWeight.w200, color: kBlackShade7Color.withOpacity(0.7)),
          ),
        ),
        DataCell(
          Text(
            rfq.city ?? "",
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp, fontWeight: FontWeight.w200, color: kBlackShade7Color.withOpacity(0.7)),
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Get.dialog(barrierDismissible: false, ViewDetailModel(rfq: rfq));
                  },
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: kPrimaryColor,
                    child: Center(child: SvgPicture.asset(kEditIcon, height: 16.h, width: 16.w)),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Obx(
                  () =>
                      controller.isLoadingRFQStatus.value
                          ? const Center(child: CircularProgressIndicator())
                          : GestureDetector(
                            onTap: () {
                              final reasonController = TextEditingController();

                              Get.dialog(
                                barrierDismissible: false,
                                CustomDialog(
                                  image: kRejectReasonImage,
                                  title: kRejectionReason,
                                  btnText: kReject,
                                  isLoading: controller.isLoadingRFQStatus,
                                  onTap: () async {
                                    await controller.updateRFQStatusAction(rfqId: rfq.rfqId, status: "Rejected");
                                    reasonController.clear();
                                    showCustomSnackbar("Success", "RFQ status updated to Rejected", backgroundColor: kGreenColor);
                                  },
                                  hideDetail: true,
                                  showRejection: true,
                                  btnColor: kRedColor,

                                  reasonController: reasonController,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: kPrimaryColor,
                              child: Center(child: Icon(Icons.close, color: kWhiteColor, size: 14)),
                            ),
                          ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Obx(
                  () =>
                      controller.isLoadingRFQStatus.value
                          ? const Center(child: CircularProgressIndicator())
                          : GestureDetector(
                            onTap: () {
                              Get.dialog(
                                barrierDismissible: false,
                                CustomDialog(
                                  image: kApproveDialogImage,
                                  title: kApproveDetail,
                                  isLoading: controller.isLoadingRFQStatus,
                                  btnText: kApprove,
                                  onTap: () async {
                                    await controller.updateRFQStatusAction(rfqId: rfq.rfqId, status: "Accepted");

                                    showCustomSnackbar("Success", "RFQ status updated to Accepted", backgroundColor: kGreenColor);
                                  },
                                  hideDetail: true,
                                ),
                              );
                            },

                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: kPrimaryColor,
                              child: Center(child: SvgPicture.asset(kCheckIcon, height: 16.h, width: 16.w)),
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
