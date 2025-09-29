import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/custom_widgets/column_row.dart';
import 'package:matloob_admin/generated/locale_keys.g.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import 'package:matloob_admin/utils/common_code.dart';
import '../../../utils/app_images.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/clicks_tracking_controller.dart';

class ClickTrackingScreen extends GetView<ClickTrackingController> {
  const ClickTrackingScreen({super.key});

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
                        CommonCode().t(LocaleKeys.clicksTracking),
                        context,
                      ),
                      Text(
                        CommonCode().t(LocaleKeys.rfqIssuer),
                        style: AppStyles.blackTextStyle().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
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
                                  controller: controller.rfqSearchController,
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
                                    hintText: kFilterQuickSearch,
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
                                return SizedBox(
                                  height: 300.h,
                                  width: Get.width,
                                  child: Center(
                                    child: () {
                                      if (controller.isRFQLoading.value) {
                                        return const CircularProgressIndicator();
                                      }

                                      if (controller.pagedRFQClicks.isEmpty) {
                                        return Text(
                                          "No RFQ clicks found",
                                          style: AppStyles.blackTextStyle()
                                              .copyWith(
                                                fontSize: 16.sp,
                                                color: kBlackColor.withOpacity(
                                                  0.5,
                                                ),
                                              ),
                                        );
                                      }

                                      return Stack(
                                        children: [
                                          Container(
                                            height: 44,
                                            decoration: BoxDecoration(
                                              color: kLightBlueColor
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                  label: ColumnRowWidget(
                                                    title: kRfqID,
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: ColumnRowWidget(
                                                    title: kRFQIssuers,
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: ColumnRowWidget(
                                                    title: "Title",
                                                  ),
                                                ),
                                                DataColumn(
                                                  headingRowAlignment:
                                                      MainAxisAlignment.center,
                                                  label: ColumnRowWidget(
                                                    title: kClicks,
                                                  ),
                                                ),
                                              ],
                                              rows:
                                                  controller.pagedRFQClicks
                                                      .map(
                                                        (user) => _buildDataRow(
                                                          user.id,
                                                          user
                                                                  .usersWhoClicked
                                                                  .isEmpty
                                                              ? 'N/A'
                                                              : (user
                                                                      .usersWhoClicked[0]
                                                                      .name ??
                                                                  'N/A'),
                                                          user.title,
                                                          user.clicks
                                                              .toString(),
                                                          context,
                                                        ),
                                                      )
                                                      .toList(),
                                            ),
                                          ),
                                        ],
                                      );
                                    }(),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Obx(
                        () => CustomPagination(
                          currentPage: controller.currentRFQPage.value,
                          visiblePages: List.generate(
                            controller.totalRFQPages,
                            (index) => index + 1,
                          ),
                          onPrevious: controller.previousRFQPage,
                          onNext: controller.nextRFQPage,
                          onPageSelected: (page) {
                            controller.currentRFQPage.value = page;
                          },
                        ),
                      ),

                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Text(
                            CommonCode().t(LocaleKeys.storeClicksTracking),
                            style: AppStyles.blackTextStyle().copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
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
                                  controller: controller.storeSearchController,
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
                                    hintText: kFilterQuickSearch,
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
                                return SizedBox(
                                  height: 300.h,
                                  width: Get.width,
                                  child: Center(
                                    child: () {
                                      if (controller.isStoreLoading.value) {
                                        return const CircularProgressIndicator();
                                      }

                                      if (controller.pagedStoreClicks.isEmpty) {
                                        return Text(
                                          "No store clicks found",
                                          style: AppStyles.blackTextStyle()
                                              .copyWith(
                                                fontSize: 16.sp,
                                                color: kBlackColor.withOpacity(
                                                  0.5,
                                                ),
                                              ),
                                        );
                                      }

                                      return Stack(
                                        children: [
                                          Container(
                                            height: 44,
                                            decoration: BoxDecoration(
                                              color: kLightBlueColor
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                  label: ColumnRowWidget(
                                                    title: kStoreID,
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: ColumnRowWidget(
                                                    title: kStoreOwner,
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: ColumnRowWidget(
                                                    title: kCategory,
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: ColumnRowWidget(
                                                    title: "Clicks",
                                                  ),
                                                ),
                                                DataColumn(
                                                  headingRowAlignment:
                                                      MainAxisAlignment.center,
                                                  label: ColumnRowWidget(
                                                    title: kCity,
                                                  ),
                                                ),
                                              ],
                                              rows:
                                                  controller.pagedStoreClicks
                                                      .map(
                                                        (user) =>
                                                            _buildDataRow1(
                                                              user.id,
                                                              user.companyName,
                                                              user.speciality,
                                                              user.clicks
                                                                  .toString(),
                                                              user.location,
                                                              context,
                                                            ),
                                                      )
                                                      .toList(),
                                            ),
                                          ),
                                        ],
                                      );
                                    }(),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Obx(
                        () => CustomPagination(
                          currentPage: controller.currentStorePage.value,
                          visiblePages: List.generate(
                            controller.totalStorePages,
                            (index) => index + 1,
                          ),
                          onPrevious: controller.previousStorePage,
                          onNext: controller.nextStorePage,
                          onPageSelected: (page) {
                            controller.currentStorePage.value = page;
                          },
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
    String issuer,
    String clicks,

    context,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            id,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w200,
              color: kBlackShade7Color.withOpacity(0.7),
            ),
          ),
        ),
        DataCell(
          Text(
            name,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w200,
              color: kBlackShade7Color.withOpacity(0.7),
            ),
          ),
        ),
        DataCell(
          Text(
            issuer,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w200,
              color: kBlackShade7Color.withOpacity(0.7),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              clicks,
              textAlign: TextAlign.center,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w200,
                color: kBlackShade7Color.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ],
    );
  }

  DataRow _buildDataRow1(
    String id,
    String name,
    String speciality,
    String clicks,
    String location,
    context,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            id,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w200,
              color: kBlackShade7Color.withOpacity(0.7),
            ),
          ),
        ),
        DataCell(
          Text(
            name,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w200,
              color: kBlackShade7Color.withOpacity(0.7),
            ),
          ),
        ),
        DataCell(
          Text(
            speciality,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w200,
              color: kBlackShade7Color.withOpacity(0.7),
            ),
          ),
        ),
        DataCell(
          Text(
            clicks,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w200,
              color: kBlackShade7Color.withOpacity(0.7),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              location,
              textAlign: TextAlign.center,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w200,
                color: kBlackShade7Color.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
