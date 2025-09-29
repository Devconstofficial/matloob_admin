import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:matloob_admin/custom_widgets/add_store_dialog.dart';
import 'package:matloob_admin/custom_widgets/column_row.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/custom_widgets/custom_dialog.dart';
import 'package:matloob_admin/custom_widgets/view_store_detail_model.dart';
import 'package:matloob_admin/generated/locale_keys.g.dart';
import 'package:matloob_admin/models/store_model.dart';
import 'package:matloob_admin/screens/sidemenu/sidemenu.dart';
import 'package:matloob_admin/screens/store_management/controller/store_controller.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import 'package:matloob_admin/utils/common_code.dart';
import '../../../utils/app_images.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/custom_pagination.dart';

class StoreManagementScreen extends GetView<StoreController> {
  const StoreManagementScreen({super.key});

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
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 40.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customHeader(
                        CommonCode().t(LocaleKeys.storeManagement),
                        context,
                      ),
                      Row(
                        children: [
                          Text(
                            CommonCode().t(LocaleKeys.registeredStores),
                            style: AppStyles.blackTextStyle().copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                          const Spacer(),
                          Obx(
                            () =>
                                controller.isExporting.value
                                    ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                    : CustomButton(
                                      title: CommonCode().t(
                                        LocaleKeys.exportAsExcel,
                                      ),
                                      onTap: () {
                                        controller.exportStoresToExcel();
                                      },
                                      height: 40.h,
                                      width: 146.w,
                                      textSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          SizedBox(width: 22.w),
                          Obx(
                            () =>
                                controller.isAdding.value
                                    ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                    : CustomButton(
                                      title:
                                          "+ ${CommonCode().t(LocaleKeys.addStore)}",
                                      onTap: () {
                                        Get.dialog(
                                          barrierDismissible: false,
                                          AddStoreDialog(),
                                        );
                                      },
                                      height: 40.h,
                                      width: 128.w,
                                      textSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: kGreyColor, width: 0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                            top: 24,
                            right: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 45.h,
                                width: 300.w,
                                child: TextField(
                                  controller: controller.searchController,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: kBlackColor,
                                  ),
                                  decoration: InputDecoration(
                                    hintStyle: GoogleFonts.roboto(
                                      color: kBlackColor.withOpacity(0.2),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    ),
                                    hintText: CommonCode().t(
                                      LocaleKeys.filterQuickSearch,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        kSearchIcon1,
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    fillColor: kBlackColor.withOpacity(0.04),
                                    filled: true,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Obx(() {
                                if (controller.storeRequests.isEmpty) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text("No stores found."),
                                    ),
                                  );
                                }
                                return Stack(
                                  children: [
                                    Container(
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: kLightBlueColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width,
                                      child: DataTable(
                                        columnSpacing: 0,
                                        headingRowHeight: 44,
                                        dataRowMinHeight: 55,
                                        dataRowMaxHeight: 55,
                                        dividerThickness: 0.2,
                                        columns: [
                                          DataColumn(
                                            label: Flexible(
                                              flex: 1,
                                              child: ColumnRowWidget(
                                                title: CommonCode().t(
                                                  LocaleKeys.storeId,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Flexible(
                                              flex: 1,
                                              child: ColumnRowWidget(
                                                title: CommonCode().t(
                                                  LocaleKeys.companyName,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Flexible(
                                              flex: 1,
                                              child: ColumnRowWidget(
                                                title: CommonCode().t(
                                                  LocaleKeys.registeredOn,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Flexible(
                                              flex: 1,
                                              child: ColumnRowWidget(
                                                title: CommonCode().t(
                                                  LocaleKeys.views,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Flexible(
                                              flex: 1,
                                              child: ColumnRowWidget(
                                                title: CommonCode().t(
                                                  LocaleKeys.companyNumber,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Flexible(
                                              flex: 1,
                                              child: ColumnRowWidget(
                                                title: CommonCode().t(
                                                  LocaleKeys.location,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Flexible(
                                              flex: 1,
                                              child: ColumnRowWidget(
                                                title: CommonCode().t(
                                                  LocaleKeys.speciality,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Flexible(
                                              flex: 1,
                                              child: ColumnRowWidget(
                                                title: CommonCode().t(
                                                  LocaleKeys.status,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            headingRowAlignment:
                                                MainAxisAlignment.center,
                                            label: Flexible(
                                              flex: 1,
                                              child: ColumnRowWidget(
                                                title: CommonCode().t(
                                                  LocaleKeys.action,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows:
                                            controller.filteredStores
                                                .map(
                                                  (store) => _buildDataRow(
                                                    store.id,
                                                    store.companyName,
                                                    store.createdAt
                                                            ?.toIso8601String() ??
                                                        "",
                                                    (store.views).toString(),
                                                    store.companyNumber,
                                                    store.location,
                                                    store.speciality,
                                                    store.storeStatus.name,
                                                    store,
                                                    context,
                                                  ),
                                                )
                                                .toList(),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 29.h),
                      Obx(
                        () => CustomPagination(
                          currentPage: controller.currentPage.value,
                          visiblePages: controller.visiblePageNumbers,
                          onPrevious: controller.goToPreviousPage,
                          onNext: controller.goToNextPage,
                          onPageSelected: controller.goToPage,
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

  DataRow _buildDataRow(
    String id,
    String name,
    String registeredOn,
    String views,
    String number,
    String location,
    String specialty,
    String status,
    Store store,
    context,
  ) {
    DateTime? dateTime = DateTime.tryParse(registeredOn);

    String formattedDate =
        dateTime != null ? DateFormat('dd-MM-yyyy').format(dateTime) : 'N/A';
    return DataRow(
      cells: [
        DataCell(
          MouseRegion(
            cursor: SystemMouseCursors.click,

            child: GestureDetector(
              onTap: () {
                controller.fetchStoreDetails(store.id);
                Get.toNamed(kViewStoreDetailsScreenRoute);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  id,
                  style: _cellStyle(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ),
        DataCell(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              name,
              style: _cellStyle(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        DataCell(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              formattedDate,
              style: _cellStyle(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        DataCell(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              views,
              style: _cellStyle(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        DataCell(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              number,
              style: _cellStyle(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        DataCell(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              location,
              style: _cellStyle(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        DataCell(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              specialty,
              style: _cellStyle(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        DataCell(
          Container(
            width: 71,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color:
                  status == "Accepted"
                      ? kPrimaryColor.withOpacity(0.2)
                      : status == kPending
                      ? kBrownColor.withOpacity(0.2)
                      : kRedColor.withOpacity(0.2),
            ),
            child: Center(
              child: Text(
                status,
                textAlign: TextAlign.center,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color:
                      status == "Accepted"
                          ? kPrimaryColor
                          : status == kPending
                          ? kBrownColor
                          : kRedColor,
                ),
              ),
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () =>
                    controller.isDeleting.value
                        ? const Center(child: CircularProgressIndicator())
                        : _actionButton(
                          icon: kDeleteIcon,
                          onTap: () {
                            Get.dialog(
                              barrierDismissible: false,
                              CustomDialog(
                                image: kDeleteDialogImage,
                                title: CommonCode().t(
                                  LocaleKeys.areYouSureWantToDelete,
                                ),
                                btnText: CommonCode().t(
                                  LocaleKeys.confirmDelete,
                                ),
                                isLoading: controller.isDeleting,
                                onTap: () {
                                  controller.deleteStoreInController(store.id);
                                },
                                btnColor: kRedColor,
                                hideDetail: true,
                              ),
                            );
                          },
                        ),
              ),
              SizedBox(width: 8.w),
              _actionButton(
                icon: kEditIcon,
                onTap: () {
                  controller.selectedStatus.value = status;
                  Get.dialog(
                    ViewStoreDetailModel(
                      showEditApprove: false,
                      onEdit: () {},
                      selectedStatus: controller.selectedStatus,
                      showStoreEdit: true,
                      store: store,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextStyle _cellStyle() {
    return AppStyles.blackTextStyle().copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w200,
      color: kBlackShade7Color.withOpacity(0.7),
    );
  }

  Widget _actionButton({required String icon, required VoidCallback onTap}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: 14,
          backgroundColor: kPrimaryColor,
          child: Center(
            child: SvgPicture.asset(icon, height: 16.h, width: 16.w),
          ),
        ),
      ),
    );
  }
}
