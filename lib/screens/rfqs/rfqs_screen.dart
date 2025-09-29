import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/custom_widgets/column_row.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/custom_widgets/view_details_dialog.dart';
import 'package:matloob_admin/generated/locale_keys.g.dart';
import 'package:matloob_admin/models/rfq_model.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import 'package:matloob_admin/utils/common_code.dart';
import '../../../utils/app_images.dart';
import '../../custom_widgets/custom_dialog.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/rfq_controller.dart';

class RfqScreen extends GetView<RfqController> {
  const RfqScreen({super.key});

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
                      customHeader(CommonCode().t(LocaleKeys.rfqs), context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            CommonCode().t(LocaleKeys.submittedRfqs),
                            style: AppStyles.blackTextStyle().copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
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
                                        controller.exportRFQsToExcel();
                                      },
                                      height: 40.h,
                                      width: 146.w,
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
                                final rfqs = controller.pagedRFQs;
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
                                            label: ColumnRowWidget(
                                              title: CommonCode().t(
                                                LocaleKeys.rfqId,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: ColumnRowWidget(
                                              title: CommonCode().t(
                                                LocaleKeys.submittedBy,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: ColumnRowWidget(
                                              title: CommonCode().t(
                                                LocaleKeys.category,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: ColumnRowWidget(
                                              title: CommonCode().t(
                                                LocaleKeys.city,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: ColumnRowWidget(
                                              title: CommonCode().t(
                                                LocaleKeys.submittedOn,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: ColumnRowWidget(
                                              title: CommonCode().t(
                                                LocaleKeys.responses,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: ColumnRowWidget(
                                              title: CommonCode().t(
                                                LocaleKeys.status,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            headingRowAlignment:
                                                MainAxisAlignment.center,
                                            label: ColumnRowWidget(
                                              title: CommonCode().t(
                                                LocaleKeys.action,
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows:
                                            rfqs.map((rfq) {
                                              return _buildDataRow(
                                                rfq.rfqId,
                                                rfq.user?.name ?? "-",
                                                rfq.category,
                                                rfq.city ?? "-",
                                                rfq.createdAt != null
                                                    ? CommonCode.formatDate(
                                                      rfq.createdAt!,
                                                    )
                                                    : "-",
                                                rfq.clicks,
                                                rfq.status.name,
                                                rfq,
                                                context,
                                              );
                                            }).toList(),
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
    String submittedBy,
    String category,
    String city,
    String submitOn,
    int responses,
    String status,
    RfqModel rfq,
    BuildContext context,
  ) {
    return DataRow(
      cells: [
        DataCell(_buildClickableText(id)),
        DataCell(_buildClickableText(submittedBy)),
        DataCell(_buildClickableText(category)),
        DataCell(_buildClickableText(city)),
        DataCell(_buildClickableText(submitOn)),
        DataCell(
          Text(
            responses.toString(),
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w200,
              color: kBlackShade7Color.withOpacity(0.7),
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
                      : status == "Rejected"
                      ? kRedColor.withOpacity(0.2)
                      : kBrownColor.withOpacity(0.2),
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
                          : status == "Rejected"
                          ? kRedColor
                          : kBrownColor,
                ),
              ),
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
                child: Obx(
                  () =>
                      controller.isDeleting.value
                          ? const Center(child: CircularProgressIndicator())
                          : GestureDetector(
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
                                    controller.deleteRFQAction(id, responses);
                                  },
                                  btnColor: kRedColor,
                                  hideDetail: true,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: kPrimaryColor,
                              child: Center(
                                child: SvgPicture.asset(
                                  kDeleteIcon,
                                  height: 16.h,
                                  width: 16.w,
                                ),
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
                      barrierDismissible: false,
                      ViewDetailModel(rfq: rfq, isEditable: false),
                    );
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClickableText(String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppStyles.blackTextStyle().copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w200,
          color: kBlackShade7Color.withOpacity(0.7),
        ),
      ),
    );
  }
}
