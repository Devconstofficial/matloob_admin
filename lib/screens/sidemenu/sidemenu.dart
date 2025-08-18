import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import 'controller/sidemenu_controller.dart';


class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}


class _SideMenuState extends State<SideMenu> {
  final menuController = Get.put(SideMenuController());

  @override
  Widget build(BuildContext context) {

    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      backgroundColor: kWhiteColor,
      width: 212.w,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: kBlackColor.withOpacity(0.1),
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kBlackColor.withOpacity(0.1),
                        width: 0.5
                      )
                    )
                  ),
                  child: Center(
                    child: SizedBox(
                        height: 50.h,
                        width: 100.w,
                        child: Center(
                          child: SvgPicture.asset(
                            kLogoImage,
                            fit: BoxFit.fitWidth,
                          ),)
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30.h,),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(0);
                              Get.toNamed(kDashboardScreenRoute);
                            },
                            child: Container(
                                height: 40,
                                width: 190,
                                decoration: BoxDecoration(
                                  color: menuController.selectedIndex.value == 0 ? kPrimaryColor.withOpacity(0.05) : kWhiteColor,
                                  border: Border.all(
                                    color: menuController.selectedIndex.value == 0 ? kPrimaryColor : kWhiteColor
                                  ),
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        kDashboardIcon,
                                        height: 20,
                                        width: 20,
                                          color: menuController.selectedIndex.value == 0 ? kPrimaryColor : kGreyColor5,
                                        ),
                                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                      Flexible(
                                        child: Text(
                                          kDashboard,
                                          style: AppStyles.blackTextStyle().copyWith(
                                              color: menuController.selectedIndex.value == 0
                                                  ? kPrimaryColor : kGreyColor5,
                                              fontSize: 14,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 12,),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(1);
                              Get.toNamed(kStoreManagementScreenRoute);
                            },
                            child: Container(
                                height: 40,
                                width: 190,

                                decoration: BoxDecoration(
                                    color: menuController.selectedIndex.value == 1 ? kPrimaryColor.withOpacity(0.05) : kWhiteColor,
                                    border: Border.all(
                                        color: menuController.selectedIndex.value == 1 ? kPrimaryColor : kWhiteColor
                                    ),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        kStoreIcon,
                                        height: 20,
                                        width: 20,
                                        color: menuController.selectedIndex.value == 1 ? kPrimaryColor : kGreyColor5,
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                      Flexible(
                                        child: Text(
                                          kStoreManagement,
                                          style: AppStyles.blackTextStyle().copyWith(
                                              color: menuController.selectedIndex.value == 1
                                                  ? kPrimaryColor : kGreyColor5,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 12,),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(2);
                              Get.toNamed(kUserManagementScreenRoute);
                            },
                            child: Container(
                                height: 40,
                                width: 190,
                                decoration: BoxDecoration(
                                    color: menuController.selectedIndex.value == 2 ? kPrimaryColor.withOpacity(0.05) : kWhiteColor,
                                    border: Border.all(
                                        color: menuController.selectedIndex.value == 2 ? kPrimaryColor : kWhiteColor
                                    ),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        kDoubleUserIcon,
                                        height: 20,
                                        width: 20,
                                        color: menuController.selectedIndex.value == 2 ? kPrimaryColor : kGreyColor5,
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                      Flexible(
                                        child: Text(
                                          kUserManagement,
                                          style: AppStyles.blackTextStyle().copyWith(
                                              color: menuController.selectedIndex.value == 2
                                                  ? kPrimaryColor : kGreyColor5,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 12,),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(3);
                              Get.toNamed(kRfqScreenRoute);
                            },
                            child: Container(
                                height: 40,
                                width: 190,
                                decoration: BoxDecoration(
                                    color: menuController.selectedIndex.value == 3 ? kPrimaryColor.withOpacity(0.05) : kWhiteColor,
                                    border: Border.all(
                                        color: menuController.selectedIndex.value == 3 ? kPrimaryColor : kWhiteColor
                                    ),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        kRfqIcon,
                                        height: 20,
                                        width: 20,
                                        color: menuController.selectedIndex.value == 3 ? kPrimaryColor : kGreyColor5,
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                      Flexible(
                                        child: Text(
                                          kRFQ,
                                          style: AppStyles.blackTextStyle().copyWith(
                                              color: menuController.selectedIndex.value == 3
                                                  ? kPrimaryColor : kGreyColor5,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 12,),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(4);
                              Get.toNamed(kClickTrackingScreenRoute);
                            },
                            child: Container(
                                height: 40,
                                width: 190,
                                decoration: BoxDecoration(
                                    color: menuController.selectedIndex.value == 4 ? kPrimaryColor.withOpacity(0.05) : kWhiteColor,
                                    border: Border.all(
                                        color: menuController.selectedIndex.value == 4 ? kPrimaryColor : kWhiteColor
                                    ),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        kClicksIcon,
                                        height: 20,
                                        width: 20,
                                        color: menuController.selectedIndex.value == 4 ? kPrimaryColor : kGreyColor5,
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                      Flexible(
                                        child: Text(
                                          kClicksTracking,
                                          style: AppStyles.blackTextStyle().copyWith(
                                              color: menuController.selectedIndex.value == 4
                                                  ? kPrimaryColor : kGreyColor5,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40,right: 15),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(kAuthScreenRoute);
                    },
                    child: Container(
                        height: 49,
                        width: 180,
                        decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only( left: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(kLogoutIcon,height: 20,width: 20,),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                              Text(
                                kLOGOUT,
                                style: AppStyles.blackTextStyle().copyWith(
                                    color: kRedColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                )
              ),

            ],
          ),
        ),
      ),
    );
  }
}