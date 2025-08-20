import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/custom_widgets/column_row.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import '../../../utils/app_images.dart';
import '../../custom_widgets/add_store_dialog.dart';
import '../../custom_widgets/custom_dialog.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../../custom_widgets/view_store_detail_model.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  insightContainer(String img, String title, String detail, Color color) {
    return Container(
      width: 180.w,
      height: 94.h,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBlackColor.withOpacity(0.1)),
      ),
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      img,
                      height: 22.h,
                      width: 22.w,
                      color: kWhiteColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6.h,
                    children: [
                      Text(
                        title,
                        style: AppStyles.blackTextStyle().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 19.sp,
                        ),
                      ),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 40.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customHeader(kDashboard),
                      Wrap(
                        spacing: 15.w,
                        runSpacing: 15.w,
                        children: [
                          insightContainer(
                            kDoubleUserIcon,
                            "1,000",
                            kTotalUsers,
                            kGreenColor,
                          ),
                          insightContainer(
                            kDownloadIcon,
                            "1,000",
                            kTotalDownloads,
                            kPrimaryColor,
                          ),
                          insightContainer(
                            kAddStoreIcon,
                            "200",
                            kPendingStores,
                            kGreenColor,
                          ),
                          insightContainer(
                            kAddStoreIcon,
                            "400",
                            kLiveStores,
                            kPrimaryColor,
                          ),
                          insightContainer(
                            kAddRfqIcon,
                            "100",
                            kTotalRFQs,
                            kGreenColor,
                          ),
                          insightContainer(
                            kAddRfqIcon,
                            "100",
                            kPendingRFQs,
                            kPrimaryColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kPendingStoreRequests,
                            style: AppStyles.blackTextStyle().copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                          CustomButton(
                            title: "+ $kAddStore",
                            onTap: () {
                              Get.dialog(AddStoreModel(selectedCountry: controller.selectedCountry,));
                            },
                            height: 40.h,
                            width: 128.w,
                            textSize: 16.sp,
                            fontWeight: FontWeight.w500,
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
                          padding: const EdgeInsets.all(24),
                          child: Stack(
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
                                      label: Row(
                                        spacing: 3,
                                        children: [
                                          Text(
                                            "Company name",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: AppStyles.blackTextStyle()
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                ),
                                          ),
                                          SvgPicture.asset(
                                            kUpDownArrowsIcon,
                                            height: 13,
                                            width: 9,
                                          ),
                                        ],
                                      ),
                                    ),
                                    DataColumn(
                                      label: Row(
                                        spacing: 3,
                                        children: [
                                          Text(
                                            "Company Number",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: AppStyles.blackTextStyle()
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                ),
                                          ),
                                          SvgPicture.asset(
                                            kUpDownArrowsIcon,
                                            height: 13,
                                            width: 9,
                                          ),
                                        ],
                                      ),
                                    ),
                                    DataColumn(
                                      label: Row(
                                        spacing: 3,
                                        children: [
                                          Text(
                                            "Location",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: AppStyles.blackTextStyle()
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                ),
                                          ),
                                          SvgPicture.asset(
                                            kUpDownArrowsIcon,
                                            height: 13,
                                            width: 9,
                                          ),
                                        ],
                                      ),
                                    ),
                                    DataColumn(
                                      label: Row(
                                        spacing: 3,
                                        children: [
                                          Text(
                                            "Specialty",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: AppStyles.blackTextStyle()
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                ),
                                          ),
                                          SvgPicture.asset(
                                            kUpDownArrowsIcon,
                                            height: 13,
                                            width: 9,
                                          ),
                                        ],
                                      ),
                                    ),
                                    DataColumn(
                                      headingRowAlignment:
                                          MainAxisAlignment.center,
                                      label: Flexible(
                                        child: Text(
                                          "Action",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: AppStyles.blackTextStyle()
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows:
                                      controller.storeRequests
                                          .map(
                                            (user) => _buildDataRow(
                                              user['name']!,
                                              user['companyNumber']!,
                                              user['location']!,
                                              user['speciality']!,
                                              context,
                                            ),
                                          )
                                          .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Text(
                            kPendingRFQs,
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
                          padding: const EdgeInsets.all(24),
                          child: Stack(
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
                                      label: ColumnRowWidget(title: "RFQ ID"),
                                    ),
                                    DataColumn(
                                      label: ColumnRowWidget(
                                        title: "Submitted By",
                                      ),
                                    ),
                                    DataColumn(
                                      label: ColumnRowWidget(title: "Category"),
                                    ),
                                    DataColumn(
                                      label: ColumnRowWidget(title: "City"),
                                    ),
                                    DataColumn(
                                      headingRowAlignment:
                                          MainAxisAlignment.center,
                                      label: ColumnRowWidget(title: "Action"),
                                    ),
                                  ],
                                  rows:
                                      controller.rfqs
                                          .map(
                                            (user) => _buildDataRow(
                                              user['id']!,
                                              user['submittedBy']!,
                                              user['category']!,
                                              user['city']!,
                                              context,
                                            ),
                                          )
                                          .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Obx(() => CustomPagination(
                      //   currentPage: controller.currentPage2.value,
                      //   visiblePages: controller.visiblePageNumbers,
                      //   onPrevious: controller.goToPreviousPage,
                      //   onNext: controller.goToNextPage,
                      //   onPageSelected: controller.goToPage,
                      // )),
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
    String name,
    String number,
    String location,
    String specialty,
    context,
  ) {
    return DataRow(
      cells: [
        DataCell(
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Get.dialog(ViewStoreDetailModel(showEditApprove: true,onEdit: (){

                },selectedStatus: controller.selectedCountry,));
              },
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w200,
                  color: kBlackShade7Color.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ),
        DataCell(
          Text(
            number,
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
            location,
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
            specialty,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w200,
              color: kBlackShade7Color.withOpacity(0.7),
            ),
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
                    Get.dialog(ViewStoreDetailModel(selectedStatus: controller.selectedCountry,));
                  },
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: kPrimaryColor,
                    child: Center(
                      child: SvgPicture.asset(
                        kEditIcon,
                        height: 16.h,
                        width: 16.w,
                      ),
                    ),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
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
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: kPrimaryColor,
                    child: Center(
                      child: Icon(Icons.close, color: kWhiteColor, size: 14),
                    ),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Get.dialog(
                      CustomDialog(
                        image: kApproveDialogImage,
                        title: kApproveDetail,
                        btnText: kApprove,
                        onTap: () {
                          Get.back();
                        },
                        hideDetail: true,
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: kPrimaryColor,
                    child: Center(
                      child: SvgPicture.asset(
                        kCheckIcon,
                        height: 16.h,
                        width: 16.w,
                      ),
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
