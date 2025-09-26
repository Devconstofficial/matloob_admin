import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/custom_widgets/add_user_dialog.dart';
import 'package:matloob_admin/custom_widgets/column_row.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/models/user_analytics_model.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import '../../../utils/app_images.dart';
import '../../custom_widgets/custom_dialog.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../../custom_widgets/user_detail_dialog.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/user_controller.dart';

class UserManagementScreen extends GetView<UserController> {
  const UserManagementScreen({super.key});

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
                      customHeader(kUserManagement),
                      Obx(
                        () => insightContainer(
                          kDoubleUserIcon,
                          controller.totalUsers.value.toString(),
                          kOnlineUsers,
                          kGreenColor,
                        ),
                      ),

                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kRegisteredUsers,
                            style: AppStyles.blackTextStyle().copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () =>
                                    controller.isExporting.value
                                        ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                        : CustomButton(
                                          title: kExportAsExcel,
                                          onTap: () {
                                            controller.exportUsersToExcel();
                                          },
                                          height: 40.h,
                                          width: 146.w,
                                          textSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                              SizedBox(width: 12.w),
                              Obx(
                                ()=> controller.isAdding.value?const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                        : CustomButton(
                                  title: "+ Add User",
                                  onTap: () {
                                    Get.dialog(
                                      barrierDismissible: false,
                                      AddUserDialog(),
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
                                if (controller.isLoading.value) {
                                  return SizedBox(
                                    height: 200.h,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                if (controller.filteredUsers.isEmpty) {
                                  return SizedBox(
                                    height: 200.h,
                                    child: Center(
                                      child: Text(
                                        "No users found",
                                        style: GoogleFonts.roboto(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: kBlackColor.withOpacity(0.6),
                                        ),
                                      ),
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
                                            label: ColumnRowWidget(
                                              title: kUserID,
                                            ),
                                          ),
                                          DataColumn(
                                            label: ColumnRowWidget(
                                              title: kUserName,
                                            ),
                                          ),
                                          DataColumn(
                                            label: ColumnRowWidget(
                                              title: kPhoneNo,
                                            ),
                                          ),
                                          DataColumn(
                                            label: ColumnRowWidget(
                                              title: kCompanyName,
                                            ),
                                          ),
                                          DataColumn(
                                            label: ColumnRowWidget(
                                              title: kEmail,
                                            ),
                                          ),
                                          DataColumn(
                                            label: ColumnRowWidget(
                                              title: kStatus,
                                            ),
                                          ),
                                          DataColumn(
                                            headingRowAlignment:
                                                MainAxisAlignment.center,
                                            label: ColumnRowWidget(
                                              title: kAction,
                                            ),
                                          ),
                                        ],
                                        rows:
                                            controller.pagedUsers
                                                .map(
                                                  (user) => _buildDataRow(
                                                    user.id,
                                                    user.name ?? 'N/A',
                                                    user.mobile ?? 'N/A',
                                                    user.companyName ?? 'N/A',
                                                    user.email ?? 'N/A',
                                                    user.status,
                                                    user,
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
                      Obx(() {
                        if (controller.filteredUsers.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return CustomPagination(
                          currentPage: controller.currentPage.value,
                          visiblePages: controller.visiblePageNumbers,
                          onPrevious: controller.goToPreviousPage,
                          onNext: controller.goToNextPage,
                          onPageSelected: controller.goToPage,
                        );
                      }),
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
    String phNo,
    String compName,
    String email,
    String status,
    UserWithAnalytics user,
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
            phNo,
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
            compName,
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
            email,
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
                  status.toLowerCase() == "active"
                      ? kPrimaryColor.withOpacity(0.2)
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
                      status.toLowerCase() == "active"
                          ? kPrimaryColor
                          : kRedColor,
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
                                  title: kConfirmDeleteDetail,
                                  btnText: kConfirmDelete,
                                  isLoading: controller.isDeleting,
                                  onTap: () {
                                    controller.deleteUserInController(user.id);
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
                child: Obx(
                  () =>
                      controller.isUpdating.value
                          ? const Center(child: CircularProgressIndicator())
                          : GestureDetector(
                            onTap: () {
                              Get.dialog(
                                barrierDismissible: false,
                                UserDetailModel(
                                  selectedStatus: controller.selectedStatus,
                                  user: user,
                                ),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
