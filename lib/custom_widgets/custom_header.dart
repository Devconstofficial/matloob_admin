import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:matloob_admin/generated/locale_keys.g.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/utils/common_code.dart';

import '../utils/app_images.dart';
import '../utils/app_styles.dart';

Widget customHeader(String title, context) {
  return Padding(
    padding: EdgeInsets.only(bottom: 29.h),
    child: Row(
      children: [
        Text(
          title,
          style: AppStyles.blackTextStyle().copyWith(
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        SizedBox(width: 21.w),
        IconButton(
          icon: const Icon(Icons.language),
          onPressed: () {
            _showLanguageDialog(context);
          },
        ),
        SizedBox(width: 21.w),
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(kPersonImage, fit: BoxFit.cover),
          ),
        ),
      ],
    ),
  );
}

void _showLanguageDialog(BuildContext context) {
  Get.dialog(
    AlertDialog(
      backgroundColor: kWhiteColor,
      title: Text("Select Language"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("English"),
            onTap: () async {
              await context.setLocale(const Locale('en', 'US'));
              Get.back();
              Get.updateLocale(const Locale("en", "US"));
            },
          ),
          ListTile(
            title: const Text("العربية"),
            onTap: () async {
              await context.setLocale(const Locale('ar', 'SA'));
              Get.back();
              Get.updateLocale(const Locale("ar", "SA"));
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(CommonCode().t(LocaleKeys.cancel)),
        ),
      ],
    ),
    barrierDismissible: true,
  );
}
