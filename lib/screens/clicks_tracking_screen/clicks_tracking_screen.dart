import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/custom_widgets/column_row.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
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
                  padding: EdgeInsets.symmetric(horizontal: 32.w,vertical: 40.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customHeader(kClicksTracking),
                      Text(kRFQIssuerTracking,style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w500,fontSize: 18.sp),),
                      SizedBox(height: 12.h,),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: kGreyColor, width: 0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24,top: 24,right: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 45.h,
                                width: 300.w,
                                child: TextField(
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
                                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
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
                              SizedBox(height: 20.h,),
                              Stack(
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
                                          label: ColumnRowWidget(title: kRfqID),
                                        ),
                                        DataColumn(
                                          label: ColumnRowWidget(title: kRFQIssuers),
                                        ),
                                        DataColumn(
                                          label: ColumnRowWidget(title: kClickedBy),
                                        ),
                                        DataColumn(
                                          headingRowAlignment: MainAxisAlignment.center,
                                          label: ColumnRowWidget(title: kClicks),
                                        ),
                                      ],
                                      rows: controller.pagedUsers2
                                          .map((user) => _buildDataRow(
                                          user['id']!,
                                          user['issuer']!,
                                          user['clickedBy']!,
                                          user['clicks']!,
                                          context))
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Obx(() => CustomPagination(
                        currentPage: controller.currentPage2.value,
                        visiblePages: controller.visiblePageNumbers2,
                        onPrevious: controller.goToPreviousPage2,
                        onNext: controller.goToNextPage2,
                        onPageSelected: controller.goToPage2,
                      )),
                      SizedBox(height: 20.h,),
                      Row(
                        children: [
                          Text(kPendingRFQs,style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w500,fontSize: 18.sp),),
                        ],
                      ),
                      SizedBox(height: 12.h,),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: kGreyColor, width: 0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24,top: 24,right: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 45.h,
                                width: 300.w,
                                child: TextField(
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
                                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
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
                              SizedBox(height: 20.h,),
                              Stack(
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
                                          label: ColumnRowWidget(title: kStoreID),
                                        ),
                                        DataColumn(
                                          label: ColumnRowWidget(title: kStoreOwner),
                                        ),
                                        DataColumn(
                                          label: ColumnRowWidget(title: kCategory),
                                        ),
                                        DataColumn(
                                          headingRowAlignment: MainAxisAlignment.center,
                                          label: ColumnRowWidget(title: kCity),
                                        ),
                                      ],
                                      rows: controller.pagedUsers
                                          .map((user) => _buildDataRow(
                                          user['id']!,
                                          user['issuer']!,
                                          user['clickedBy']!,
                                          user['clicks']!,
                                          context))
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Obx(() => CustomPagination(
                        currentPage: controller.currentPage2.value,
                        visiblePages: controller.visiblePageNumbers,
                        onPrevious: controller.goToPreviousPage,
                        onNext: controller.goToNextPage,
                        onPageSelected: controller.goToPage,
                      )),
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

  DataRow _buildDataRow(String id, String name, String issuer, String clicks, context) {

    return DataRow(
      cells: [
        DataCell(Text(
          id,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w200,color: kBlackShade7Color.withOpacity(0.7)),
        )),
        DataCell(Text(
          name,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w200,color: kBlackShade7Color.withOpacity(0.7)),
        )),
        DataCell(Text(
          issuer,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w200,color: kBlackShade7Color.withOpacity(0.7)),
        )),
        DataCell(Center(
          child: Text(
            clicks,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle()
                .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w200,color: kBlackShade7Color.withOpacity(0.7)),
          ),
        )),
      ],
    );
  }
}
